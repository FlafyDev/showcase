// TODO: also allow from a specific number of likes. not just rated!
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:crypto/crypto.dart';

import 'package:drift/drift.dart';
import 'package:server/models/auth.dart';
import 'package:server/models/requests.dart';
import 'package:server/models/database.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

const gdVersion = "2.2074";
const modVersion = "1.0.0-alpha.2";
const maxReplayDataSize = 5 * 1024 * 1024; // 5MB
const maxBadPoints = 5;
const baseDashAuthUrl = "https://dashend.firee.dev/api/v1";
// const baseDashAuthUrl = "http://localhost:3002/api/v1";
const maxUserSubmissions = 10;

enum SubmissionEvaluation {
  needed,
  notNeeded,
  ignore,
}

enum ReplayFeedback {
  success,
  userBadInput,
  replayFailed,
  timedOut,
  unknown,
  notNeeded,
}

class ShowcaseServer {
  late final HttpServer server;
  late final ShowcaseDatabase db;
  final Map<String, CachedAuthTokenData> cachedTokens;
  final Directory gdDir;
  final String pgHostname;
  final int pgPort;
  final String pgUsername;
  final String pgPassword;
  final String pgDatabaseName;
  final File playerBinaryFile;
  final int httpPort;

  File get gdLevelDataFile => File(path.join(gdDir.path, "level.dat"));
  File get gdResponseFile => File(path.join(gdDir.path, "response.json"));
  File get gdReplayFile => File(path.join(gdDir.path, "replay.gdr2"));

  ShowcaseServer({
    required this.gdDir,
    required this.pgHostname,
    required this.pgPort,
    required this.pgUsername,
    required this.pgPassword,
    required this.pgDatabaseName,
    required this.playerBinaryFile,
    required this.httpPort,
  }) : cachedTokens = {} {
    db = ShowcaseDatabase(
      host: pgHostname,
      port: pgPort,
      databaseName: pgDatabaseName,
      username: pgUsername,
      password: pgPassword,
    );

    final app = Router();

    app.post('/needed_submissions', (Request request) async {
      final jsonData = json.decode(await request.readAsString());
      if (jsonData is! Map<String, Object?>) {
        return Response.badRequest(
          body: "Invalid JSON format. Expected a Map.",
        );
      }

      final body = NeededSubmissionsRequest.fromJson(jsonData);

      final accountID = await authenticateUser(body.dashAuthToken);
      if (accountID == null) {
        return Response.unauthorized(null);
      }

      List<int> notNeededIndexes = [];
      int? neededIndex;

      for (final (index, submission) in body.submissions.indexed) {
        switch (await evaluateSubmission(submission, accountID)) {
          case SubmissionEvaluation.ignore:
            break;
          case SubmissionEvaluation.notNeeded:
            notNeededIndexes.add(index);
            break;
          case SubmissionEvaluation.needed:
            neededIndex = index;
            break;
        }
      }

      return Response.ok(json.encode({
        "notNeeded": notNeededIndexes,
        "submit": neededIndex,
      }));
    });

    app.post('/upload_submission', (Request request) async {
      final body = UploadSubmissionRequest.fromJson(
          json.decode(await request.readAsString()));

      final accountID = await authenticateUser(body.dashAuthToken);
      if (accountID == null) {
        return Response.unauthorized(null);
      }

      if (await evaluateSubmission(body.submission, accountID) !=
          SubmissionEvaluation.needed) {
        await addBadPoint(
            accountID, "User tried adding a submission that isn't needed.");
        return Response.forbidden("Submission not needed");
      }

      if (body.submission.dataBase64 == null) {
        await addBadPoint(accountID, "No replay data given");
        return Response.forbidden('No replay data given');
      }

      Uint8List replayData = base64.decode(body.submission.dataBase64!);

      if (replayData.length > maxReplayDataSize) {
        await addBadPoint(accountID, "Given Replay data was too large");
        return Response.forbidden('Replay data too large');
      }

      Uint8List recomputedReplayHash =
          Uint8List.fromList(sha256.convert(replayData).bytes);

      await addLevelToDB(levelID: body.submission.levelID);

      await db.into(db.submissions).insert(
            SubmissionsCompanion(
              levelID: Value(body.submission.levelID),
              levelVersion: Value(body.submission.levelVersion),
              status: Value(SubmissionStatus.pendingReview),
              replayHash: Value(recomputedReplayHash),
              replayData: Value(replayData),
              modVersion: Value(modVersion),
              gdVersion: Value(gdVersion),
              gdAccountID: Value(accountID),
              rejectionReason: Value(""),
              submittedAt: Value(DateTime.now()),
            ),
          );
      print(
          "Added submission for level ${body.submission.levelID} by $accountID");
      return Response.ok(null);
    });

    app.post('/get_submission', (Request request) async {
      final body = GetSubmissionRequest.fromJson(
          json.decode(await request.readAsString()));
      if (body.gdVersion != gdVersion || body.modVersion != modVersion) {
        return Response.notFound("Bad gd/mod versions");
      }
      print("Getting replay for level: ${body.levelID}");

      print("Increasing access...");
      await addLevelToDB(levelID: body.levelID, addedAccesses: 1);

      print("Looking for replay...");
      final submission = await getSubmissionForLevel(body.levelID);
      if (submission == null) {
        return Response.notFound("No replay found for level ${body.levelID}");
      }
      print("Got valid replay");

      return Response.ok(base64.encode(submission.replayData!));
    });

    playLevelsLoop();

    io.serve(app.call, '0.0.0.0', httpPort).then((server) {
      this.server = server;
      print('Serving public at http://${server.address.host}:${server.port}');
    });
  }

  Future<void> playLevelsLoop() async {
    Process? process;
    while (true) {
      process?.kill(ProcessSignal.sigterm);
      await Future.delayed(Duration(seconds: 2));
      try {
        final submission = await nextSubmissionInQueue();

        if (submission == null) {
          continue;
        }

        print(
            "Checking submission ID: ${submission.id} for level ${submission.levelID}.");

        ReplayFeedback feedback = ReplayFeedback.unknown;

        try {
          switch (await evaluateSubmission(
            RequestSubmissionInfo.fromDBSubmission(submission),
            submission.gdAccountID,
            alreadyAdded: true,
          )) {
            case SubmissionEvaluation.ignore:
              throw Exception(
                  "Submission should never be ignored if already added.");
            case SubmissionEvaluation.notNeeded:
              feedback = ReplayFeedback.notNeeded;
              break;
            case SubmissionEvaluation.needed:
              if (submission.levelID <= 4000) {
                feedback = ReplayFeedback.userBadInput;
                break;
              }

              final res = await http.post(
                Uri.parse(
                    "http://www.boomlings.com/database/getGJLevels21.php"),
                body: "secret=Wmfd2893gb7&type=10&str=${submission.levelID}",
                headers: {
                  "Content-Type": "application/x-www-form-urlencoded",
                  "User-Agent": "",
                },
              );

              final resBody = utf8.decode(res.bodyBytes, allowMalformed: true);

              if (res.statusCode != 200) {
                feedback = ReplayFeedback.userBadInput;
                break;
              }
              if (resBody == "-1") {
                feedback = ReplayFeedback.userBadInput;
                break;
              }

              print(resBody);

              List<String> sections = resBody.split("#");

              final levelInfoDict = parseGDDict(sections[0]);
              final creatorInfoDict = parseGDDict(sections[1]);

              final levelName = levelInfoDict["2"];
              final levelCreatorID = levelInfoDict["6"];
              final levelCreator = creatorInfoDict[levelCreatorID];
              final levelDescription = utf8.decode(
                  base64.decode(levelInfoDict["3"]!),
                  allowMalformed: true);
              final levelVersion = int.parse(levelInfoDict["5"]!);
              final levelStars = int.parse(levelInfoDict["18"]!);
              final levelLikes = int.parse(levelInfoDict["14"]!);
              final isClassic = levelInfoDict["15"] != "5";

              LevelDifficulty difficulty = LevelDifficulty.unknown;
              final isDemon = levelInfoDict["15"] == "1";
              if (isDemon) {
                final demonDiff = levelInfoDict["43"];
                switch (demonDiff) {
                  case "3":
                    difficulty = LevelDifficulty.easyDemon;
                    break;
                  case "4":
                    difficulty = LevelDifficulty.mediumDemon;
                    break;
                  case "0":
                    difficulty = LevelDifficulty.hardDemon;
                    break;
                  case "5":
                    difficulty = LevelDifficulty.insaneDemon;
                    break;
                  case "6":
                    difficulty = LevelDifficulty.extremeDemon;
                    break;
                  default:
                    difficulty = LevelDifficulty.unknown;
                }
              } else {
                final nonDemonDiff = levelInfoDict["9"];
                switch (nonDemonDiff) {
                  case "10":
                    difficulty = LevelDifficulty.easy;
                    break;
                  case "20":
                    difficulty = LevelDifficulty.normal;
                    break;
                  case "30":
                    difficulty = LevelDifficulty.hard;
                    break;
                  case "40":
                    difficulty = LevelDifficulty.harder;
                    break;
                  case "50":
                    difficulty = LevelDifficulty.insane;
                    break;
                  default:
                    difficulty = LevelDifficulty.unknown;
                }
              }

              await addLevelToDB(
                levelID: submission.levelID,
                cachedVersion: levelVersion,
                cachedTitle: levelName,
                cachedCreator: levelCreator,
                cachedDescription: levelDescription,
                cachedStars: levelStars,
                cachedDifficulty: difficulty,
                cachedLikes: levelLikes,
              );

              if (!isClassic ||
                  levelStars < 2 ||
                  submission.levelVersion > levelVersion) {
                feedback = ReplayFeedback.userBadInput;
                break;
              }

              if (levelVersion != submission.levelVersion) {
                feedback = ReplayFeedback.notNeeded;
                break;
              }

              // delete response.json
              if (await gdResponseFile.exists()) {
                await gdResponseFile.delete();
              }

              // force stop the vm
              process?.kill(ProcessSignal.sigkill);

              // get level data
              final resLevelData = await http.post(
                Uri.parse(
                    "http://www.boomlings.com/database/downloadGJLevel22.php"),
                body: "secret=Wmfd2893gb7&levelID=${submission.levelID}",
                headers: {
                  "Content-Type": "application/x-www-form-urlencoded",
                  "User-Agent": "",
                },
              );

              final resLevelDataBody =
                  utf8.decode(resLevelData.bodyBytes, allowMalformed: true);

              if (resLevelData.statusCode != 200) {
                feedback = ReplayFeedback.userBadInput;
                break;
              }
              if (resLevelDataBody == "-1") {
                feedback = ReplayFeedback.userBadInput;
                break;
              }

              // write in level.dat what level to play
              await gdLevelDataFile.writeAsString(
                resLevelDataBody.split("#")[0],
              );

              // write in replay.gdr2 the replay data
              await gdReplayFile.writeAsBytes(submission.replayData!);

              // run the vm
              process = await Process.start(playerBinaryFile.path, []);
              process.stderr.listen((event) {
                stdout.write(String.fromCharCodes(event));
              });
              process.stdout.listen((event) {
                stdout.write(String.fromCharCodes(event));
              });

              // wait and read response.json for the result
              final startTime = DateTime.now();
              print("Waiting for VM to complete the level...");
              while (!await gdResponseFile.exists() &&
                  await _isProcessAlive(process)) {
                await Future.delayed(Duration(milliseconds: 1000));
                if (DateTime.now().difference(startTime).inSeconds > 150) {
                  feedback = ReplayFeedback.timedOut;
                  break;
                }
              }
              if (feedback == ReplayFeedback.timedOut ||
                  !await gdResponseFile.exists()) {
                break;
              }

              process.kill(ProcessSignal.sigterm);

              final responseJson =
                  json.decode(await gdResponseFile.readAsString());

              if (responseJson["success"] == true) {
                feedback = ReplayFeedback.success;
              } else {
                feedback = ReplayFeedback.replayFailed;
              }

              break;
          }
        } catch (e, stacktraceVar) {
          print("Failed due to $e.\n$stacktraceVar");
          feedback = ReplayFeedback.unknown;
        }

        print(
            "Done checking(levelID: ${submission.levelID}). Feedback: $feedback");
        switch (feedback) {
          case ReplayFeedback.success:
            await acceptSubmission(submission.id);
            break;
          case ReplayFeedback.userBadInput:
            await addBadPoint(
              submission.gdAccountID,
              "Bad point during replay check. Probably replay for an invalid level.",
            );
            await rejectSubmission(
                submission.id, "Bad input. Bad point given.");
            break;
          case ReplayFeedback.replayFailed:
            await rejectSubmission(
                submission.id, "Tried to play replay and failed");
            break;
          case ReplayFeedback.unknown:
            await rejectSubmission(
                submission.id, "Unknown reason for failing.");
            break;
          case ReplayFeedback.timedOut:
            await rejectSubmission(submission.id, "Timed out.");
            break;
          case ReplayFeedback.notNeeded:
            await rejectSubmission(submission.id, "Not needed.");
            break;
        }
      } catch (e, stacktraceVar) {
        print("Play levels loop failed: $e\n\nStacktrace: $stacktraceVar");
      }
    }
  }

  Future<void> acceptSubmission(int submissionID) async {
    await (db.update(db.submissions)
          ..where((tbl) => tbl.id.equals(submissionID)))
        .write(
      SubmissionsCompanion(
        status: Value(SubmissionStatus.accepted),
        reviewedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> rejectSubmission(int submissionID, String reason) async {
    final formattedReason = "\n\n${DateTime.now().toIso8601String()}: $reason";
    await (db.update(db.submissions)
          ..where((tbl) => tbl.id.equals(submissionID)))
        .write(
      SubmissionsCompanion.custom(
        status: Variable(SubmissionStatus.rejected.index),
        // replayData: Variable(null),
        rejectionReason:
            db.submissions.rejectionReason + Variable(formattedReason),
        reviewedAt: Variable(DateTime.now()),
      ),
    );
  }

  Future<SubmissionEvaluation> evaluateSubmission(
    RequestSubmissionInfo submission,
    int accountID, {
    bool alreadyAdded = false,
  }) async {
    if (submission.gdVersion != gdVersion ||
        submission.modVersion != modVersion) {
      return SubmissionEvaluation.notNeeded;
    }

    // not needed if a submission already exists for the level
    final acceptedSubmission = await getSubmissionForLevel(submission.levelID);
    if (acceptedSubmission != null) {
      return SubmissionEvaluation.notNeeded;
    }

    // HACK
    if (submission.dataBase64 != null) {
      final dataLength = base64.decode(submission.dataBase64!).length;
      if (dataLength < 50) {
        print("The submission's replay is smaller than 100 bytes");
        return SubmissionEvaluation.notNeeded;
      }
    }

    // not needed if user already has 10 pending submissions
    if (!alreadyAdded) {
      final userSubmission = await (db.select(db.submissions)
            ..where((tbl) =>
                tbl.status.equals(SubmissionStatus.pendingReview.index))
            ..where((tbl) => tbl.gdAccountID.equals(accountID))
            ..limit(maxUserSubmissions))
          .get();
      if (userSubmission.length >= maxUserSubmissions) {
        return SubmissionEvaluation.ignore;
      }
    }

    return SubmissionEvaluation.needed;
  }

  Future<int?> authenticateUser(String dashAuthToken) async {
    final client = http.Client();

    int? confirmedAccountID;
    String? confirmedAccountUsername;

    if (cachedTokens.containsKey(dashAuthToken)) {
      final cachedTokenData = cachedTokens[dashAuthToken]!;
      if (DateTime.now().isAfter(cachedTokenData.tokenExpiration)) {
        cachedTokens.remove(dashAuthToken);
      } else {
        confirmedAccountID = cachedTokenData.accountID;
        confirmedAccountUsername = cachedTokenData.cachedAccountUsername;
      }
    }

    if (confirmedAccountID == null) {
      final dashAuthResponse = await client.post(
        Uri.parse("$baseDashAuthUrl/verify"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"token": dashAuthToken}),
      );

      if (dashAuthResponse.statusCode != 200) {
        return null;
      }

      final body = json.decode(dashAuthResponse.body) as Map<String, dynamic>;

      if (body["success"] != true || body["data"]["token"] != dashAuthToken) {
        return null;
      }

      confirmedAccountID = body["data"]["id"] as int;
      confirmedAccountUsername = body["data"]["username"] as String;
      final tokenExpiration =
          DateTime.parse(body["data"]["token_expiration"] as String);

      cachedTokens[dashAuthToken] = CachedAuthTokenData(
        tokenExpiration: tokenExpiration,
        accountID: confirmedAccountID,
        cachedAccountUsername: confirmedAccountUsername,
      );
    }

    if (confirmedAccountID == null || confirmedAccountUsername == null) {
      return null;
    }

    final existingUser = await (db.select(db.users)
          ..where((tbl) => tbl.accountID.equals(confirmedAccountID!))
          ..limit(1))
        .get()
        .then((l) => l.firstOrNull);

    if (existingUser == null) {
      await db.into(db.users).insert(UsersCompanion(
            accountID: Value(confirmedAccountID),
            cachedUsername: Value(confirmedAccountUsername),
            badPoints: Value(0),
            lastCacheUpdateAt: Value(DateTime.now()),
            badPointsLog: Value(""),
          ));
    } else {
      if (existingUser.badPoints > maxBadPoints) {
        return null;
      }

      final editUserQuery = await (db.update(db.users)
            ..where((tbl) => tbl.accountID.equals(confirmedAccountID!)))
          .write(UsersCompanion.custom(
              cachedUsername: Variable(confirmedAccountUsername)));
      if (editUserQuery != 1) {
        return null;
      }
    }

    return confirmedAccountID;
  }

  Future<Submission?> getSubmissionForLevel(int levelID) async {
    final queriedSubmission = await (db.select(db.submissions).join([
      innerJoin(
        db.users,
        db.users.accountID.equalsExp(db.submissions.gdAccountID),
      )
    ])
          ..limit(1)
          ..where(db.submissions.levelID.equals(levelID))
          ..where(db.submissions.status.equals(SubmissionStatus.accepted.index))
          ..where(db.submissions.modVersion.equals(modVersion))
          ..where(db.submissions.gdVersion.equals(gdVersion))
          ..where(db.submissions.replayData.isNotNull())
          ..where(db.users.badPoints.isSmallerOrEqualValue(5)))
        .get()
        .then((sub) => sub.firstOrNull?.readTable(db.submissions));
    return queriedSubmission;
  }

  Future<Submission?> nextSubmissionInQueue() async {
    final queriedSubmission = await (db.select(db.submissions).join([
      innerJoin(
        db.users,
        db.users.accountID.equalsExp(db.submissions.gdAccountID),
      )
    ])
          ..orderBy([
            OrderingTerm(
              expression: db.submissions.submittedAt,
            )
          ])
          ..limit(1)
          ..where(db.submissions.status
              .equals(SubmissionStatus.pendingReview.index))
          ..where(db.submissions.modVersion.equals(modVersion))
          ..where(db.submissions.gdVersion.equals(gdVersion))
          ..where(db.submissions.replayData.isNotNull())
          ..where(db.users.badPoints.isSmallerOrEqualValue(5)))
        .get()
        .then((sub) => sub.firstOrNull?.readTable(db.submissions));
    return queriedSubmission;
  }

  Future<void> addBadPoint(int accountID, String reason) async {
    final formattedReason = "\n\n${DateTime.now().toIso8601String()}: $reason";
    final editUserQuery = await (db.update(db.users)
          ..where((tbl) => tbl.accountID.equals(accountID)))
        .write(UsersCompanion.custom(
      badPoints: db.users.badPoints + Variable(1),
      badPointsLog: db.users.badPointsLog + Variable(formattedReason),
    ));
    if (editUserQuery != 1) {
      throw Exception("Failed to add bad point");
    }
  }

  Future<void> addLevelToDB({
    required int levelID,
    int? cachedVersion,
    String? cachedTitle,
    String? cachedCreator,
    String? cachedDescription,
    int? cachedStars,
    int? cachedLikes,
    LevelDifficulty? cachedDifficulty,
    int addedAccesses = 0,
    int? accessedAccount,
  }) async {
    final existingLevel = await (db.select(db.levels)
          ..where((tbl) => tbl.levelID.equals(levelID))
          ..limit(1))
        .get()
        .then((l) => l.firstOrNull);

    if (existingLevel != null) {
      if (cachedVersion == null &&
          cachedTitle == null &&
          cachedCreator == null &&
          cachedDescription == null &&
          cachedStars == null &&
          cachedLikes == null &&
          cachedDifficulty == null &&
          addedAccesses == 0) {
        return;
      }

      // Update existing entry instead of deleting
      await (db.update(db.levels)..where((tbl) => tbl.levelID.equals(levelID)))
          .write(
        LevelsCompanion(
          cachedVersion:
              cachedVersion != null ? Value(cachedVersion) : Value.absent(),
          cachedTitle:
              cachedTitle != null ? Value(cachedTitle) : Value.absent(),
          cachedCreator:
              cachedCreator != null ? Value(cachedCreator) : Value.absent(),
          cachedDescription: cachedDescription != null
              ? Value(cachedDescription)
              : Value.absent(),
          cachedStars:
              cachedStars != null ? Value(cachedStars) : Value.absent(),
          cachedLikes:
              cachedLikes != null ? Value(cachedLikes) : Value.absent(),
          cachedDifficulty: cachedDifficulty != null
              ? Value(cachedDifficulty)
              : Value.absent(),
          accesses: Value(existingLevel.accesses + addedAccesses),
          lastCacheUpdateAt: Value(DateTime.now()),
        ),
      );
    } else {
      // Insert new entry
      await db.into(db.levels).insert(
            LevelsCompanion(
              levelID: Value(levelID),
              cachedVersion: Value(cachedVersion),
              cachedTitle: Value(cachedTitle),
              cachedCreator: Value(cachedCreator),
              cachedDescription: Value(cachedDescription),
              cachedStars: Value(cachedStars),
              cachedLikes: Value(cachedLikes),
              cachedDifficulty: Value(cachedDifficulty),
              accesses: Value(addedAccesses),
              lastCacheUpdateAt: Value(DateTime.now()),
            ),
          );
    }

    if (addedAccesses > 0) {
      final timestamp = DateTime.now();

      await db.batch(
        (batch) {
          batch.insertAll(
            db.accesses,
            List.generate(
              addedAccesses,
              (_) => AccessesCompanion(
                gdAccountID: Value(accessedAccount),
                levelID: Value(levelID),
                accessTime: Value(timestamp),
              ),
            ),
          );
        },
      );
    }
  }

  Map<String, String> parseGDDict(String raw) {
    final pairs = raw.split(":");
    final infoDict = <String, String>{};
    for (int i = 0; i < pairs.length; i += 2) {
      if (i + 1 < pairs.length) {
        infoDict[pairs[i]] = pairs[i + 1];
      }
    }
    return infoDict;
  }
}

Future<bool> _isProcessAlive(Process process) async {
  try {
    // Try to check the exitCode, but don't await its completion
    final exitCodeFuture = process.exitCode;
    final result = await Future.any([
      exitCodeFuture,
      Future.delayed(Duration(milliseconds: 100), () => null),
    ]);

    // If result is null, the process hasn't exited yet
    return result == null;
  } catch (_) {
    // If something went wrong, assume it's not alive
    return false;
  }
}

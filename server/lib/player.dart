import 'dart:async';
import 'package:path/path.dart' as path;
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:server/utils/future_timeout.dart';

enum ReplayFeedback {
  success,
  userBadInput,
  replayFailed,
  unknown,
  timedOut,
  notNeeded,
}

class ShowcasePlayer {
  final Directory gdDir;
  final Directory winePrefixDir;
  final bool headless;

  ServerSocket? _serverSocket;
  Socket? _clientSocket;
  Stream<Uint8List>? _clientBroadcastStream;
  StreamIterator<Uint8List>? _clientStreamIterator;
  Process? _gdProcess;

  ShowcasePlayer({
    required this.gdDir,
    required this.winePrefixDir,
    required this.headless,
  });

  File get _gdExecutableFile => File(path.join(gdDir.path, "GeometryDash.exe"));
  Directory get _winePrefixStartDir =>
      Directory(path.join(winePrefixDir.parent.path, "wine_prefix_start"));

  File _getReplayQueueFile(int levelID) {
    return File(path.join(
        winePrefixDir.path,
        "drive_c/users/showcase/AppData/Local/GeometryDash/geode/mods/flafy.showcase/queue",
        "$levelID.gdr"));
  }

  Future<bool> _establishSocket() async {
    await _closeSocket();
    print("Player: Creating server socket...");
    // Shared = true in case last serverSocket wasn't closed for whatever reason
    final serverSocket =
        await ServerSocket.bind("127.0.0.1", 8081, shared: true);
    print("Player: Waiting for client socket...");
    final clientSocket = await futureTimeout(
      serverSocket.first,
      Duration(seconds: 10),
    );
    if (clientSocket == null) {
      return false;
    }
    _serverSocket = serverSocket;
    _clientSocket = clientSocket;
    _clientBroadcastStream = _clientSocket!.asBroadcastStream();
    _clientStreamIterator = StreamIterator(_clientBroadcastStream!);

    if (await _waitForCommand("client_connected") != 0) {
      return false;
    }

    return true;
  }

  Future<bool> _sendCommand(String commandName, Object arg) async {
    print("Player: Sending command: $commandName. Arg: $arg");
    if (_clientSocket == null) return false;
    try {
      await _clientStreamIterator!.cancel();
      _clientStreamIterator = StreamIterator(_clientBroadcastStream!);
    } catch (e) {
      print("Player: Error cancelling and remaking stream iterator: $e");
    }
    final sent = await futureTimeout(
      Future(() async {
        final strData = "$commandName ${json.encode(arg)}";
        final data = utf8.encode(strData);
        _clientSocket!.add(data);
        await _clientSocket!.flush();
        return true;
      }),
      const Duration(seconds: 5),
    );
    print("Player: sent: $sent");
    return sent == true;
  }

  Future<Object?> _waitForCommand(String commandName,
      [Duration timeout = const Duration(seconds: 10)]) async {
    print("Player: Waiting on \"$commandName\".");
    if (_clientSocket == null) return null;
    return futureTimeout<Object?>(
      Future<Object?>(() async {
        while (true) {
          final dataArrived =
              await futureTimeout(_clientStreamIterator!.moveNext(), timeout);
          if (dataArrived != true) return null;

          final strData = utf8.decode(_clientStreamIterator!.current);
          print("Player: GOT: $strData");
          final separatorIndex = strData.indexOf(" ");
          if (separatorIndex == -1) {
            continue;
          }
          final name = strData.substring(0, separatorIndex);
          if (name != commandName) {
            continue;
          }

          final arg = json.decode(strData.substring(separatorIndex + 1));
          return arg;
        }
      }),
      timeout,
    );
  }

  Future<void> _forceStopGD() async {
    print("Player: Force stopping GD... $_gdProcess");
    if (_gdProcess != null) {
      _gdProcess!.kill(ProcessSignal.sigterm);
      await Future.delayed(Duration(seconds: 1));
      _gdProcess!.kill(ProcessSignal.sigkill);
      _gdProcess = null;
    }

    await _closeSocket();

    await Process.run('pkill', ['-15', 'wine']).timeout(Duration(seconds: 2));
    await Process.run('pkill', ['-9', 'wine']);
  }

  Future<void> _closeSocket() async {
    print("Player: Closing socket");
    await _clientSocket?.close();
    await _clientStreamIterator?.cancel();
    await _serverSocket?.close();
    _clientSocket = null;
    _clientStreamIterator = null;
    _serverSocket = null;
    // Let's not close ourselves...
    // await Process.run('bash', ['-c', 'kill -9 \$(lsof -t -i:8081)']);
  }

  Future<bool> _runGD({bool tryUseExisting = true}) async {
    print("Player: Running GD... $_gdProcess");
    if (_gdProcess != null &&
        _serverSocket != null &&
        _clientSocket != null &&
        _clientStreamIterator != null &&
        tryUseExisting) {
      final sent = await _sendCommand("server_ping", 0);
      if (sent) {
        final pong = await _waitForCommand(
          "client_pong",
          Duration(milliseconds: 1500),
        );
        if (pong == 0) {
          return true;
        }
      }
    }

    await _forceStopGD();

    if (await winePrefixDir.exists()) {
      await winePrefixDir.delete(recursive: true);
    }

    await winePrefixDir.parent.create(recursive: true);

    // await copyPath(_winePrefixStartDir.path, winePrefixDir.path);
    final copyResult = await Process.run(
        'cp', ['-R', _winePrefixStartDir.path, winePrefixDir.path]);
    if (copyResult.exitCode != 0) {
      throw Exception(
          "Failed to copy. Error: ${copyResult.stderr.toString().trim()}");
    }

    print("Player: Starting GD Processs...");
    _gdProcess = await Process.start(
      'cage',
      [
        'wine64',
        '--',
        _gdExecutableFile.path,
      ],
      workingDirectory: gdDir.path,
      environment: {
        // Wine
        "WINEPREFIX": winePrefixDir.path,
        "WINEDLLOVERRIDES": "XInput1_4.dll=n,b",
        "USER": "showcase", // Scary?
        // Headless
        if (headless) "WLR_HEADLESS_OUTPUTS": "1",
        if (headless) "WLR_BACKENDS": "headless",
        if (headless) "WLR_LIBINPUT_NO_DEVICES": "1",
      },
    );

    _gdProcess!.stderr.listen((event) {
      print(String.fromCharCodes(event));
    });
    _gdProcess!.stdout.listen((event) {
      print(String.fromCharCodes(event));
      // final stdoutLines = String.fromCharCodes(event).split("\n");
      // for (final line in stdoutLines) {
      //   if (line.contains("[showcase]")) {
      //     print(line);
      //   }
      // }
    });

    print("Player: Waiting on socket...");
    if (!await _establishSocket()) {
      print("Failed to establish socket.");
      await _forceStopGD();
      return false;
    }
    print("Player: Socket established!");

    return true;
  }

  Future<ReplayFeedback> playReplay({
    required int levelID,
    required Uint8List replayData,
    int maxAttempts = 2,
  }) async {
    try {
      if (maxAttempts == 0) return ReplayFeedback.unknown;

      var feedback = await futureTimeout(
        _playReplayInternal(
          levelID: levelID,
          replayData: replayData,
        ),
        const Duration(seconds: 50),
      );
      print("Player: Done single internal feedback: $feedback");
      print("Player: Attempts left: ${maxAttempts - 1}");
      feedback ??= ReplayFeedback.timedOut;

      if (feedback == ReplayFeedback.unknown) {
        return playReplay(
          levelID: levelID,
          replayData: replayData,
          maxAttempts: maxAttempts - 1,
        );
      }
      return feedback;
    } catch (e, stacktrace) {
      print("Player: Error playing replay: $e\n\n${stacktrace}");
      await _forceStopGD();
      return ReplayFeedback.unknown;
    }
  }

  // Plays a replay and returns success
  Future<ReplayFeedback> _playReplayInternal({
    required int levelID,
    required Uint8List replayData,
  }) async {
    if (levelID < 4000) {
      // TODO: For now if a level is bad id then dont blame user
      // Also, remove this later.
      // return ReplayFeedback.userBadInput;
      return ReplayFeedback.replayFailed;
    }

    // Run GD and make sure it's ready
    if (!await _runGD()) {
      await _forceStopGD();
      return ReplayFeedback.unknown;
    }

    // Tell the client the levelID
    if (!await _sendCommand("server_goto_level", {"levelID": levelID})) {
      await _forceStopGD();
      return ReplayFeedback.unknown;
    }

    // Client tells if the level is valid for replay
    final levelValidInfo =
        await _waitForCommand("client_level_valid", const Duration(seconds: 20))
            as Map<String, dynamic>?;
    if (levelValidInfo == null || levelValidInfo["levelID"] != levelID) {
      await _forceStopGD();
      return ReplayFeedback.unknown;
    }

    if (!(levelValidInfo["found"] as bool) ||
        !(levelValidInfo["valid"] as bool)) {
      // await _forceStopGD();
      // TODO: For now if a level is not found then dont blame user
      // return ReplayFeedback.userBadInput;
      return ReplayFeedback.replayFailed;
    }

    // Write GDR file
    final queueFile = _getReplayQueueFile(levelID);
    await queueFile.create(recursive: true);
    await queueFile.writeAsBytes(replayData);

    await Future.delayed(const Duration(seconds: 2));

    // Client plays level and returns if the replay was successful
    await _sendCommand("server_play_level", {"levelID": levelID});

    final replayResult =
        await _waitForCommand("client_replay_result", Duration(seconds: 30))
            as Map<String, dynamic>?;
    if (replayResult == null || (replayResult["levelID"] as int) != levelID) {
      await _forceStopGD();
      return ReplayFeedback.unknown;
    }

    if ((replayResult["finished"] as bool) != true) {
      return ReplayFeedback.replayFailed;
    }

    return ReplayFeedback.success;
  }
}

// void test() async {
//   final a = ShowcasePlayer(
//     gdDir: Directory("/home/flafy/Games/data/windows/geometry-dash").absolute,
//     winePrefixDir: Directory("./wine-prefix-test").absolute,
//   );
//   final data = await File(
//           "/home/flafy/Games/wine-prefixes/geometry-dash/drive_c/users/flafy/AppData/Local/GeometryDash/geode/mods/flafy.showcase/queue/977287.gdr")
//       .readAsBytes();
//   final res = await a.playReplay(levelID: 977287, replayData: data);
//   print(res);
// }

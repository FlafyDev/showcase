import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:postgres/postgres.dart';

part 'database.g.dart';

enum SubmissionStatus {
  unknown,
  pendingReview,
  rejected,
  accepted,
}

enum LevelDifficulty {
  auto,
  easy,
  normal,
  hard,
  harder,
  insane,
  easyDemon,
  mediumDemon,
  hardDemon,
  insaneDemon,
  extremeDemon,
  unknown,
}

class Submissions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get levelID => integer().references(Levels, #levelID)();
  IntColumn get levelVersion => integer()();
  IntColumn get status => intEnum<SubmissionStatus>()();
  BlobColumn get replayHash => blob()();
  BlobColumn get replayData => blob().nullable()();
  TextColumn get modVersion => text()();
  TextColumn get gdVersion => text()();
  IntColumn get gdAccountID => integer().references(Users, #accountID)();
  TextColumn get rejectionReason => text()();
  DateTimeColumn get reviewedAt => dateTime().nullable()();
  DateTimeColumn get submittedAt => dateTime()();
}

class Levels extends Table {
  IntColumn get levelID => integer().unique()();
  TextColumn get cachedTitle => text().nullable()();
  TextColumn get cachedCreator => text().nullable()();
  TextColumn get cachedDescription => text().nullable()();
  IntColumn get cachedVersion => integer().nullable()();
  IntColumn get cachedStars => integer().nullable()();
  IntColumn get cachedDifficulty => intEnum<LevelDifficulty>().nullable()();
  IntColumn get cachedLikes => integer().nullable()();
  DateTimeColumn get lastCacheUpdateAt => dateTime()();
  IntColumn get accesses => integer().withDefault(const Constant(0))();
}

class Users extends Table {
  IntColumn get accountID => integer().unique()();
  TextColumn get cachedUsername => text()();
  IntColumn get badPoints => integer()();
  TextColumn get badPointsLog => text()();
  DateTimeColumn get lastCacheUpdateAt => dateTime()();
}

class Accesses extends Table {
  IntColumn get accessID => integer().autoIncrement()();
  IntColumn get gdAccountID => integer().references(Users, #accountID).nullable()();
  IntColumn get levelID => integer().references(Levels, #levelID)();
  DateTimeColumn get accessTime => dateTime()();
}

@DriftDatabase(tables: [Submissions, Levels, Users, Accesses])
class ShowcaseDatabase extends _$ShowcaseDatabase {
  ShowcaseDatabase({
    required String host,
    required int port,
    required String databaseName,
    required String username,
    required String password,
  }) : super(
          PgDatabase(
            endpoint: Endpoint(
              host: host,
              port: port,
              username: username,
              password: password,
              database: databaseName,
            ),
            settings: ConnectionSettings(
              // If you expect to talk to a Postgres database over a public connection,
              // please use SslMode.verifyFull instead.
              sslMode: SslMode.disable,
            ),
          ),
        );

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.addColumn(submissions, submissions.levelVersion);
            await migrator.addColumn(levels, levels.cachedVersion);
            await migrator.addColumn(levels, levels.accesses);
          }
          if (from < 3) {
            await migrator.createTable(accesses);
          }
        },
      );
}

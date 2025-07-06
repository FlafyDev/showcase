// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $LevelsTable extends Levels with TableInfo<$LevelsTable, Level> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LevelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _levelIDMeta =
      const VerificationMeta('levelID');
  @override
  late final GeneratedColumn<int> levelID = GeneratedColumn<int>(
      'level_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _cachedTitleMeta =
      const VerificationMeta('cachedTitle');
  @override
  late final GeneratedColumn<String> cachedTitle = GeneratedColumn<String>(
      'cached_title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cachedCreatorMeta =
      const VerificationMeta('cachedCreator');
  @override
  late final GeneratedColumn<String> cachedCreator = GeneratedColumn<String>(
      'cached_creator', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cachedDescriptionMeta =
      const VerificationMeta('cachedDescription');
  @override
  late final GeneratedColumn<String> cachedDescription =
      GeneratedColumn<String>('cached_description', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cachedVersionMeta =
      const VerificationMeta('cachedVersion');
  @override
  late final GeneratedColumn<int> cachedVersion = GeneratedColumn<int>(
      'cached_version', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _cachedStarsMeta =
      const VerificationMeta('cachedStars');
  @override
  late final GeneratedColumn<int> cachedStars = GeneratedColumn<int>(
      'cached_stars', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<LevelDifficulty?, int>
      cachedDifficulty = GeneratedColumn<int>(
              'cached_difficulty', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<LevelDifficulty?>(
              $LevelsTable.$convertercachedDifficultyn);
  static const VerificationMeta _cachedLikesMeta =
      const VerificationMeta('cachedLikes');
  @override
  late final GeneratedColumn<int> cachedLikes = GeneratedColumn<int>(
      'cached_likes', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _lastCacheUpdateAtMeta =
      const VerificationMeta('lastCacheUpdateAt');
  @override
  late final GeneratedColumn<DateTime> lastCacheUpdateAt =
      GeneratedColumn<DateTime>('last_cache_update_at', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _accessesMeta =
      const VerificationMeta('accesses');
  @override
  late final GeneratedColumn<int> accesses = GeneratedColumn<int>(
      'accesses', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        levelID,
        cachedTitle,
        cachedCreator,
        cachedDescription,
        cachedVersion,
        cachedStars,
        cachedDifficulty,
        cachedLikes,
        lastCacheUpdateAt,
        accesses
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'levels';
  @override
  VerificationContext validateIntegrity(Insertable<Level> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('level_i_d')) {
      context.handle(_levelIDMeta,
          levelID.isAcceptableOrUnknown(data['level_i_d']!, _levelIDMeta));
    } else if (isInserting) {
      context.missing(_levelIDMeta);
    }
    if (data.containsKey('cached_title')) {
      context.handle(
          _cachedTitleMeta,
          cachedTitle.isAcceptableOrUnknown(
              data['cached_title']!, _cachedTitleMeta));
    }
    if (data.containsKey('cached_creator')) {
      context.handle(
          _cachedCreatorMeta,
          cachedCreator.isAcceptableOrUnknown(
              data['cached_creator']!, _cachedCreatorMeta));
    }
    if (data.containsKey('cached_description')) {
      context.handle(
          _cachedDescriptionMeta,
          cachedDescription.isAcceptableOrUnknown(
              data['cached_description']!, _cachedDescriptionMeta));
    }
    if (data.containsKey('cached_version')) {
      context.handle(
          _cachedVersionMeta,
          cachedVersion.isAcceptableOrUnknown(
              data['cached_version']!, _cachedVersionMeta));
    }
    if (data.containsKey('cached_stars')) {
      context.handle(
          _cachedStarsMeta,
          cachedStars.isAcceptableOrUnknown(
              data['cached_stars']!, _cachedStarsMeta));
    }
    if (data.containsKey('cached_likes')) {
      context.handle(
          _cachedLikesMeta,
          cachedLikes.isAcceptableOrUnknown(
              data['cached_likes']!, _cachedLikesMeta));
    }
    if (data.containsKey('last_cache_update_at')) {
      context.handle(
          _lastCacheUpdateAtMeta,
          lastCacheUpdateAt.isAcceptableOrUnknown(
              data['last_cache_update_at']!, _lastCacheUpdateAtMeta));
    } else if (isInserting) {
      context.missing(_lastCacheUpdateAtMeta);
    }
    if (data.containsKey('accesses')) {
      context.handle(_accessesMeta,
          accesses.isAcceptableOrUnknown(data['accesses']!, _accessesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Level map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Level(
      levelID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level_i_d'])!,
      cachedTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cached_title']),
      cachedCreator: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cached_creator']),
      cachedDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}cached_description']),
      cachedVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cached_version']),
      cachedStars: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cached_stars']),
      cachedDifficulty: $LevelsTable.$convertercachedDifficultyn.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}cached_difficulty'])),
      cachedLikes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cached_likes']),
      lastCacheUpdateAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}last_cache_update_at'])!,
      accesses: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}accesses'])!,
    );
  }

  @override
  $LevelsTable createAlias(String alias) {
    return $LevelsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LevelDifficulty, int, int>
      $convertercachedDifficulty =
      const EnumIndexConverter<LevelDifficulty>(LevelDifficulty.values);
  static JsonTypeConverter2<LevelDifficulty?, int?, int?>
      $convertercachedDifficultyn =
      JsonTypeConverter2.asNullable($convertercachedDifficulty);
}

class Level extends DataClass implements Insertable<Level> {
  final int levelID;
  final String? cachedTitle;
  final String? cachedCreator;
  final String? cachedDescription;
  final int? cachedVersion;
  final int? cachedStars;
  final LevelDifficulty? cachedDifficulty;
  final int? cachedLikes;
  final DateTime lastCacheUpdateAt;
  final int accesses;
  const Level(
      {required this.levelID,
      this.cachedTitle,
      this.cachedCreator,
      this.cachedDescription,
      this.cachedVersion,
      this.cachedStars,
      this.cachedDifficulty,
      this.cachedLikes,
      required this.lastCacheUpdateAt,
      required this.accesses});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['level_i_d'] = Variable<int>(levelID);
    if (!nullToAbsent || cachedTitle != null) {
      map['cached_title'] = Variable<String>(cachedTitle);
    }
    if (!nullToAbsent || cachedCreator != null) {
      map['cached_creator'] = Variable<String>(cachedCreator);
    }
    if (!nullToAbsent || cachedDescription != null) {
      map['cached_description'] = Variable<String>(cachedDescription);
    }
    if (!nullToAbsent || cachedVersion != null) {
      map['cached_version'] = Variable<int>(cachedVersion);
    }
    if (!nullToAbsent || cachedStars != null) {
      map['cached_stars'] = Variable<int>(cachedStars);
    }
    if (!nullToAbsent || cachedDifficulty != null) {
      map['cached_difficulty'] = Variable<int>(
          $LevelsTable.$convertercachedDifficultyn.toSql(cachedDifficulty));
    }
    if (!nullToAbsent || cachedLikes != null) {
      map['cached_likes'] = Variable<int>(cachedLikes);
    }
    map['last_cache_update_at'] = Variable<DateTime>(lastCacheUpdateAt);
    map['accesses'] = Variable<int>(accesses);
    return map;
  }

  LevelsCompanion toCompanion(bool nullToAbsent) {
    return LevelsCompanion(
      levelID: Value(levelID),
      cachedTitle: cachedTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(cachedTitle),
      cachedCreator: cachedCreator == null && nullToAbsent
          ? const Value.absent()
          : Value(cachedCreator),
      cachedDescription: cachedDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(cachedDescription),
      cachedVersion: cachedVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(cachedVersion),
      cachedStars: cachedStars == null && nullToAbsent
          ? const Value.absent()
          : Value(cachedStars),
      cachedDifficulty: cachedDifficulty == null && nullToAbsent
          ? const Value.absent()
          : Value(cachedDifficulty),
      cachedLikes: cachedLikes == null && nullToAbsent
          ? const Value.absent()
          : Value(cachedLikes),
      lastCacheUpdateAt: Value(lastCacheUpdateAt),
      accesses: Value(accesses),
    );
  }

  factory Level.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Level(
      levelID: serializer.fromJson<int>(json['levelID']),
      cachedTitle: serializer.fromJson<String?>(json['cachedTitle']),
      cachedCreator: serializer.fromJson<String?>(json['cachedCreator']),
      cachedDescription:
          serializer.fromJson<String?>(json['cachedDescription']),
      cachedVersion: serializer.fromJson<int?>(json['cachedVersion']),
      cachedStars: serializer.fromJson<int?>(json['cachedStars']),
      cachedDifficulty: $LevelsTable.$convertercachedDifficultyn
          .fromJson(serializer.fromJson<int?>(json['cachedDifficulty'])),
      cachedLikes: serializer.fromJson<int?>(json['cachedLikes']),
      lastCacheUpdateAt:
          serializer.fromJson<DateTime>(json['lastCacheUpdateAt']),
      accesses: serializer.fromJson<int>(json['accesses']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'levelID': serializer.toJson<int>(levelID),
      'cachedTitle': serializer.toJson<String?>(cachedTitle),
      'cachedCreator': serializer.toJson<String?>(cachedCreator),
      'cachedDescription': serializer.toJson<String?>(cachedDescription),
      'cachedVersion': serializer.toJson<int?>(cachedVersion),
      'cachedStars': serializer.toJson<int?>(cachedStars),
      'cachedDifficulty': serializer.toJson<int?>(
          $LevelsTable.$convertercachedDifficultyn.toJson(cachedDifficulty)),
      'cachedLikes': serializer.toJson<int?>(cachedLikes),
      'lastCacheUpdateAt': serializer.toJson<DateTime>(lastCacheUpdateAt),
      'accesses': serializer.toJson<int>(accesses),
    };
  }

  Level copyWith(
          {int? levelID,
          Value<String?> cachedTitle = const Value.absent(),
          Value<String?> cachedCreator = const Value.absent(),
          Value<String?> cachedDescription = const Value.absent(),
          Value<int?> cachedVersion = const Value.absent(),
          Value<int?> cachedStars = const Value.absent(),
          Value<LevelDifficulty?> cachedDifficulty = const Value.absent(),
          Value<int?> cachedLikes = const Value.absent(),
          DateTime? lastCacheUpdateAt,
          int? accesses}) =>
      Level(
        levelID: levelID ?? this.levelID,
        cachedTitle: cachedTitle.present ? cachedTitle.value : this.cachedTitle,
        cachedCreator:
            cachedCreator.present ? cachedCreator.value : this.cachedCreator,
        cachedDescription: cachedDescription.present
            ? cachedDescription.value
            : this.cachedDescription,
        cachedVersion:
            cachedVersion.present ? cachedVersion.value : this.cachedVersion,
        cachedStars: cachedStars.present ? cachedStars.value : this.cachedStars,
        cachedDifficulty: cachedDifficulty.present
            ? cachedDifficulty.value
            : this.cachedDifficulty,
        cachedLikes: cachedLikes.present ? cachedLikes.value : this.cachedLikes,
        lastCacheUpdateAt: lastCacheUpdateAt ?? this.lastCacheUpdateAt,
        accesses: accesses ?? this.accesses,
      );
  Level copyWithCompanion(LevelsCompanion data) {
    return Level(
      levelID: data.levelID.present ? data.levelID.value : this.levelID,
      cachedTitle:
          data.cachedTitle.present ? data.cachedTitle.value : this.cachedTitle,
      cachedCreator: data.cachedCreator.present
          ? data.cachedCreator.value
          : this.cachedCreator,
      cachedDescription: data.cachedDescription.present
          ? data.cachedDescription.value
          : this.cachedDescription,
      cachedVersion: data.cachedVersion.present
          ? data.cachedVersion.value
          : this.cachedVersion,
      cachedStars:
          data.cachedStars.present ? data.cachedStars.value : this.cachedStars,
      cachedDifficulty: data.cachedDifficulty.present
          ? data.cachedDifficulty.value
          : this.cachedDifficulty,
      cachedLikes:
          data.cachedLikes.present ? data.cachedLikes.value : this.cachedLikes,
      lastCacheUpdateAt: data.lastCacheUpdateAt.present
          ? data.lastCacheUpdateAt.value
          : this.lastCacheUpdateAt,
      accesses: data.accesses.present ? data.accesses.value : this.accesses,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Level(')
          ..write('levelID: $levelID, ')
          ..write('cachedTitle: $cachedTitle, ')
          ..write('cachedCreator: $cachedCreator, ')
          ..write('cachedDescription: $cachedDescription, ')
          ..write('cachedVersion: $cachedVersion, ')
          ..write('cachedStars: $cachedStars, ')
          ..write('cachedDifficulty: $cachedDifficulty, ')
          ..write('cachedLikes: $cachedLikes, ')
          ..write('lastCacheUpdateAt: $lastCacheUpdateAt, ')
          ..write('accesses: $accesses')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      levelID,
      cachedTitle,
      cachedCreator,
      cachedDescription,
      cachedVersion,
      cachedStars,
      cachedDifficulty,
      cachedLikes,
      lastCacheUpdateAt,
      accesses);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Level &&
          other.levelID == this.levelID &&
          other.cachedTitle == this.cachedTitle &&
          other.cachedCreator == this.cachedCreator &&
          other.cachedDescription == this.cachedDescription &&
          other.cachedVersion == this.cachedVersion &&
          other.cachedStars == this.cachedStars &&
          other.cachedDifficulty == this.cachedDifficulty &&
          other.cachedLikes == this.cachedLikes &&
          other.lastCacheUpdateAt == this.lastCacheUpdateAt &&
          other.accesses == this.accesses);
}

class LevelsCompanion extends UpdateCompanion<Level> {
  final Value<int> levelID;
  final Value<String?> cachedTitle;
  final Value<String?> cachedCreator;
  final Value<String?> cachedDescription;
  final Value<int?> cachedVersion;
  final Value<int?> cachedStars;
  final Value<LevelDifficulty?> cachedDifficulty;
  final Value<int?> cachedLikes;
  final Value<DateTime> lastCacheUpdateAt;
  final Value<int> accesses;
  final Value<int> rowid;
  const LevelsCompanion({
    this.levelID = const Value.absent(),
    this.cachedTitle = const Value.absent(),
    this.cachedCreator = const Value.absent(),
    this.cachedDescription = const Value.absent(),
    this.cachedVersion = const Value.absent(),
    this.cachedStars = const Value.absent(),
    this.cachedDifficulty = const Value.absent(),
    this.cachedLikes = const Value.absent(),
    this.lastCacheUpdateAt = const Value.absent(),
    this.accesses = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LevelsCompanion.insert({
    required int levelID,
    this.cachedTitle = const Value.absent(),
    this.cachedCreator = const Value.absent(),
    this.cachedDescription = const Value.absent(),
    this.cachedVersion = const Value.absent(),
    this.cachedStars = const Value.absent(),
    this.cachedDifficulty = const Value.absent(),
    this.cachedLikes = const Value.absent(),
    required DateTime lastCacheUpdateAt,
    this.accesses = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : levelID = Value(levelID),
        lastCacheUpdateAt = Value(lastCacheUpdateAt);
  static Insertable<Level> custom({
    Expression<int>? levelID,
    Expression<String>? cachedTitle,
    Expression<String>? cachedCreator,
    Expression<String>? cachedDescription,
    Expression<int>? cachedVersion,
    Expression<int>? cachedStars,
    Expression<int>? cachedDifficulty,
    Expression<int>? cachedLikes,
    Expression<DateTime>? lastCacheUpdateAt,
    Expression<int>? accesses,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (levelID != null) 'level_i_d': levelID,
      if (cachedTitle != null) 'cached_title': cachedTitle,
      if (cachedCreator != null) 'cached_creator': cachedCreator,
      if (cachedDescription != null) 'cached_description': cachedDescription,
      if (cachedVersion != null) 'cached_version': cachedVersion,
      if (cachedStars != null) 'cached_stars': cachedStars,
      if (cachedDifficulty != null) 'cached_difficulty': cachedDifficulty,
      if (cachedLikes != null) 'cached_likes': cachedLikes,
      if (lastCacheUpdateAt != null) 'last_cache_update_at': lastCacheUpdateAt,
      if (accesses != null) 'accesses': accesses,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LevelsCompanion copyWith(
      {Value<int>? levelID,
      Value<String?>? cachedTitle,
      Value<String?>? cachedCreator,
      Value<String?>? cachedDescription,
      Value<int?>? cachedVersion,
      Value<int?>? cachedStars,
      Value<LevelDifficulty?>? cachedDifficulty,
      Value<int?>? cachedLikes,
      Value<DateTime>? lastCacheUpdateAt,
      Value<int>? accesses,
      Value<int>? rowid}) {
    return LevelsCompanion(
      levelID: levelID ?? this.levelID,
      cachedTitle: cachedTitle ?? this.cachedTitle,
      cachedCreator: cachedCreator ?? this.cachedCreator,
      cachedDescription: cachedDescription ?? this.cachedDescription,
      cachedVersion: cachedVersion ?? this.cachedVersion,
      cachedStars: cachedStars ?? this.cachedStars,
      cachedDifficulty: cachedDifficulty ?? this.cachedDifficulty,
      cachedLikes: cachedLikes ?? this.cachedLikes,
      lastCacheUpdateAt: lastCacheUpdateAt ?? this.lastCacheUpdateAt,
      accesses: accesses ?? this.accesses,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (levelID.present) {
      map['level_i_d'] = Variable<int>(levelID.value);
    }
    if (cachedTitle.present) {
      map['cached_title'] = Variable<String>(cachedTitle.value);
    }
    if (cachedCreator.present) {
      map['cached_creator'] = Variable<String>(cachedCreator.value);
    }
    if (cachedDescription.present) {
      map['cached_description'] = Variable<String>(cachedDescription.value);
    }
    if (cachedVersion.present) {
      map['cached_version'] = Variable<int>(cachedVersion.value);
    }
    if (cachedStars.present) {
      map['cached_stars'] = Variable<int>(cachedStars.value);
    }
    if (cachedDifficulty.present) {
      map['cached_difficulty'] = Variable<int>($LevelsTable
          .$convertercachedDifficultyn
          .toSql(cachedDifficulty.value));
    }
    if (cachedLikes.present) {
      map['cached_likes'] = Variable<int>(cachedLikes.value);
    }
    if (lastCacheUpdateAt.present) {
      map['last_cache_update_at'] = Variable<DateTime>(lastCacheUpdateAt.value);
    }
    if (accesses.present) {
      map['accesses'] = Variable<int>(accesses.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LevelsCompanion(')
          ..write('levelID: $levelID, ')
          ..write('cachedTitle: $cachedTitle, ')
          ..write('cachedCreator: $cachedCreator, ')
          ..write('cachedDescription: $cachedDescription, ')
          ..write('cachedVersion: $cachedVersion, ')
          ..write('cachedStars: $cachedStars, ')
          ..write('cachedDifficulty: $cachedDifficulty, ')
          ..write('cachedLikes: $cachedLikes, ')
          ..write('lastCacheUpdateAt: $lastCacheUpdateAt, ')
          ..write('accesses: $accesses, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _accountIDMeta =
      const VerificationMeta('accountID');
  @override
  late final GeneratedColumn<int> accountID = GeneratedColumn<int>(
      'account_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _cachedUsernameMeta =
      const VerificationMeta('cachedUsername');
  @override
  late final GeneratedColumn<String> cachedUsername = GeneratedColumn<String>(
      'cached_username', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _badPointsMeta =
      const VerificationMeta('badPoints');
  @override
  late final GeneratedColumn<int> badPoints = GeneratedColumn<int>(
      'bad_points', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _badPointsLogMeta =
      const VerificationMeta('badPointsLog');
  @override
  late final GeneratedColumn<String> badPointsLog = GeneratedColumn<String>(
      'bad_points_log', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastCacheUpdateAtMeta =
      const VerificationMeta('lastCacheUpdateAt');
  @override
  late final GeneratedColumn<DateTime> lastCacheUpdateAt =
      GeneratedColumn<DateTime>('last_cache_update_at', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [accountID, cachedUsername, badPoints, badPointsLog, lastCacheUpdateAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('account_i_d')) {
      context.handle(
          _accountIDMeta,
          accountID.isAcceptableOrUnknown(
              data['account_i_d']!, _accountIDMeta));
    } else if (isInserting) {
      context.missing(_accountIDMeta);
    }
    if (data.containsKey('cached_username')) {
      context.handle(
          _cachedUsernameMeta,
          cachedUsername.isAcceptableOrUnknown(
              data['cached_username']!, _cachedUsernameMeta));
    } else if (isInserting) {
      context.missing(_cachedUsernameMeta);
    }
    if (data.containsKey('bad_points')) {
      context.handle(_badPointsMeta,
          badPoints.isAcceptableOrUnknown(data['bad_points']!, _badPointsMeta));
    } else if (isInserting) {
      context.missing(_badPointsMeta);
    }
    if (data.containsKey('bad_points_log')) {
      context.handle(
          _badPointsLogMeta,
          badPointsLog.isAcceptableOrUnknown(
              data['bad_points_log']!, _badPointsLogMeta));
    } else if (isInserting) {
      context.missing(_badPointsLogMeta);
    }
    if (data.containsKey('last_cache_update_at')) {
      context.handle(
          _lastCacheUpdateAtMeta,
          lastCacheUpdateAt.isAcceptableOrUnknown(
              data['last_cache_update_at']!, _lastCacheUpdateAtMeta));
    } else if (isInserting) {
      context.missing(_lastCacheUpdateAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      accountID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}account_i_d'])!,
      cachedUsername: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}cached_username'])!,
      badPoints: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bad_points'])!,
      badPointsLog: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bad_points_log'])!,
      lastCacheUpdateAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}last_cache_update_at'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int accountID;
  final String cachedUsername;
  final int badPoints;
  final String badPointsLog;
  final DateTime lastCacheUpdateAt;
  const User(
      {required this.accountID,
      required this.cachedUsername,
      required this.badPoints,
      required this.badPointsLog,
      required this.lastCacheUpdateAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['account_i_d'] = Variable<int>(accountID);
    map['cached_username'] = Variable<String>(cachedUsername);
    map['bad_points'] = Variable<int>(badPoints);
    map['bad_points_log'] = Variable<String>(badPointsLog);
    map['last_cache_update_at'] = Variable<DateTime>(lastCacheUpdateAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      accountID: Value(accountID),
      cachedUsername: Value(cachedUsername),
      badPoints: Value(badPoints),
      badPointsLog: Value(badPointsLog),
      lastCacheUpdateAt: Value(lastCacheUpdateAt),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      accountID: serializer.fromJson<int>(json['accountID']),
      cachedUsername: serializer.fromJson<String>(json['cachedUsername']),
      badPoints: serializer.fromJson<int>(json['badPoints']),
      badPointsLog: serializer.fromJson<String>(json['badPointsLog']),
      lastCacheUpdateAt:
          serializer.fromJson<DateTime>(json['lastCacheUpdateAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountID': serializer.toJson<int>(accountID),
      'cachedUsername': serializer.toJson<String>(cachedUsername),
      'badPoints': serializer.toJson<int>(badPoints),
      'badPointsLog': serializer.toJson<String>(badPointsLog),
      'lastCacheUpdateAt': serializer.toJson<DateTime>(lastCacheUpdateAt),
    };
  }

  User copyWith(
          {int? accountID,
          String? cachedUsername,
          int? badPoints,
          String? badPointsLog,
          DateTime? lastCacheUpdateAt}) =>
      User(
        accountID: accountID ?? this.accountID,
        cachedUsername: cachedUsername ?? this.cachedUsername,
        badPoints: badPoints ?? this.badPoints,
        badPointsLog: badPointsLog ?? this.badPointsLog,
        lastCacheUpdateAt: lastCacheUpdateAt ?? this.lastCacheUpdateAt,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      accountID: data.accountID.present ? data.accountID.value : this.accountID,
      cachedUsername: data.cachedUsername.present
          ? data.cachedUsername.value
          : this.cachedUsername,
      badPoints: data.badPoints.present ? data.badPoints.value : this.badPoints,
      badPointsLog: data.badPointsLog.present
          ? data.badPointsLog.value
          : this.badPointsLog,
      lastCacheUpdateAt: data.lastCacheUpdateAt.present
          ? data.lastCacheUpdateAt.value
          : this.lastCacheUpdateAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('accountID: $accountID, ')
          ..write('cachedUsername: $cachedUsername, ')
          ..write('badPoints: $badPoints, ')
          ..write('badPointsLog: $badPointsLog, ')
          ..write('lastCacheUpdateAt: $lastCacheUpdateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      accountID, cachedUsername, badPoints, badPointsLog, lastCacheUpdateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.accountID == this.accountID &&
          other.cachedUsername == this.cachedUsername &&
          other.badPoints == this.badPoints &&
          other.badPointsLog == this.badPointsLog &&
          other.lastCacheUpdateAt == this.lastCacheUpdateAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> accountID;
  final Value<String> cachedUsername;
  final Value<int> badPoints;
  final Value<String> badPointsLog;
  final Value<DateTime> lastCacheUpdateAt;
  final Value<int> rowid;
  const UsersCompanion({
    this.accountID = const Value.absent(),
    this.cachedUsername = const Value.absent(),
    this.badPoints = const Value.absent(),
    this.badPointsLog = const Value.absent(),
    this.lastCacheUpdateAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required int accountID,
    required String cachedUsername,
    required int badPoints,
    required String badPointsLog,
    required DateTime lastCacheUpdateAt,
    this.rowid = const Value.absent(),
  })  : accountID = Value(accountID),
        cachedUsername = Value(cachedUsername),
        badPoints = Value(badPoints),
        badPointsLog = Value(badPointsLog),
        lastCacheUpdateAt = Value(lastCacheUpdateAt);
  static Insertable<User> custom({
    Expression<int>? accountID,
    Expression<String>? cachedUsername,
    Expression<int>? badPoints,
    Expression<String>? badPointsLog,
    Expression<DateTime>? lastCacheUpdateAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountID != null) 'account_i_d': accountID,
      if (cachedUsername != null) 'cached_username': cachedUsername,
      if (badPoints != null) 'bad_points': badPoints,
      if (badPointsLog != null) 'bad_points_log': badPointsLog,
      if (lastCacheUpdateAt != null) 'last_cache_update_at': lastCacheUpdateAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? accountID,
      Value<String>? cachedUsername,
      Value<int>? badPoints,
      Value<String>? badPointsLog,
      Value<DateTime>? lastCacheUpdateAt,
      Value<int>? rowid}) {
    return UsersCompanion(
      accountID: accountID ?? this.accountID,
      cachedUsername: cachedUsername ?? this.cachedUsername,
      badPoints: badPoints ?? this.badPoints,
      badPointsLog: badPointsLog ?? this.badPointsLog,
      lastCacheUpdateAt: lastCacheUpdateAt ?? this.lastCacheUpdateAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountID.present) {
      map['account_i_d'] = Variable<int>(accountID.value);
    }
    if (cachedUsername.present) {
      map['cached_username'] = Variable<String>(cachedUsername.value);
    }
    if (badPoints.present) {
      map['bad_points'] = Variable<int>(badPoints.value);
    }
    if (badPointsLog.present) {
      map['bad_points_log'] = Variable<String>(badPointsLog.value);
    }
    if (lastCacheUpdateAt.present) {
      map['last_cache_update_at'] = Variable<DateTime>(lastCacheUpdateAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('accountID: $accountID, ')
          ..write('cachedUsername: $cachedUsername, ')
          ..write('badPoints: $badPoints, ')
          ..write('badPointsLog: $badPointsLog, ')
          ..write('lastCacheUpdateAt: $lastCacheUpdateAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SubmissionsTable extends Submissions
    with TableInfo<$SubmissionsTable, Submission> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubmissionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _levelIDMeta =
      const VerificationMeta('levelID');
  @override
  late final GeneratedColumn<int> levelID = GeneratedColumn<int>(
      'level_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES levels (level_i_d)'));
  static const VerificationMeta _levelVersionMeta =
      const VerificationMeta('levelVersion');
  @override
  late final GeneratedColumn<int> levelVersion = GeneratedColumn<int>(
      'level_version', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<SubmissionStatus, int> status =
      GeneratedColumn<int>('status', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<SubmissionStatus>($SubmissionsTable.$converterstatus);
  static const VerificationMeta _replayHashMeta =
      const VerificationMeta('replayHash');
  @override
  late final GeneratedColumn<Uint8List> replayHash = GeneratedColumn<Uint8List>(
      'replay_hash', aliasedName, false,
      type: DriftSqlType.blob, requiredDuringInsert: true);
  static const VerificationMeta _replayDataMeta =
      const VerificationMeta('replayData');
  @override
  late final GeneratedColumn<Uint8List> replayData = GeneratedColumn<Uint8List>(
      'replay_data', aliasedName, true,
      type: DriftSqlType.blob, requiredDuringInsert: false);
  static const VerificationMeta _modVersionMeta =
      const VerificationMeta('modVersion');
  @override
  late final GeneratedColumn<String> modVersion = GeneratedColumn<String>(
      'mod_version', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _gdVersionMeta =
      const VerificationMeta('gdVersion');
  @override
  late final GeneratedColumn<String> gdVersion = GeneratedColumn<String>(
      'gd_version', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _gdAccountIDMeta =
      const VerificationMeta('gdAccountID');
  @override
  late final GeneratedColumn<int> gdAccountID = GeneratedColumn<int>(
      'gd_account_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (account_i_d)'));
  static const VerificationMeta _rejectionReasonMeta =
      const VerificationMeta('rejectionReason');
  @override
  late final GeneratedColumn<String> rejectionReason = GeneratedColumn<String>(
      'rejection_reason', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _reviewedAtMeta =
      const VerificationMeta('reviewedAt');
  @override
  late final GeneratedColumn<DateTime> reviewedAt = GeneratedColumn<DateTime>(
      'reviewed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _submittedAtMeta =
      const VerificationMeta('submittedAt');
  @override
  late final GeneratedColumn<DateTime> submittedAt = GeneratedColumn<DateTime>(
      'submitted_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        levelID,
        levelVersion,
        status,
        replayHash,
        replayData,
        modVersion,
        gdVersion,
        gdAccountID,
        rejectionReason,
        reviewedAt,
        submittedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'submissions';
  @override
  VerificationContext validateIntegrity(Insertable<Submission> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('level_i_d')) {
      context.handle(_levelIDMeta,
          levelID.isAcceptableOrUnknown(data['level_i_d']!, _levelIDMeta));
    } else if (isInserting) {
      context.missing(_levelIDMeta);
    }
    if (data.containsKey('level_version')) {
      context.handle(
          _levelVersionMeta,
          levelVersion.isAcceptableOrUnknown(
              data['level_version']!, _levelVersionMeta));
    } else if (isInserting) {
      context.missing(_levelVersionMeta);
    }
    if (data.containsKey('replay_hash')) {
      context.handle(
          _replayHashMeta,
          replayHash.isAcceptableOrUnknown(
              data['replay_hash']!, _replayHashMeta));
    } else if (isInserting) {
      context.missing(_replayHashMeta);
    }
    if (data.containsKey('replay_data')) {
      context.handle(
          _replayDataMeta,
          replayData.isAcceptableOrUnknown(
              data['replay_data']!, _replayDataMeta));
    }
    if (data.containsKey('mod_version')) {
      context.handle(
          _modVersionMeta,
          modVersion.isAcceptableOrUnknown(
              data['mod_version']!, _modVersionMeta));
    } else if (isInserting) {
      context.missing(_modVersionMeta);
    }
    if (data.containsKey('gd_version')) {
      context.handle(_gdVersionMeta,
          gdVersion.isAcceptableOrUnknown(data['gd_version']!, _gdVersionMeta));
    } else if (isInserting) {
      context.missing(_gdVersionMeta);
    }
    if (data.containsKey('gd_account_i_d')) {
      context.handle(
          _gdAccountIDMeta,
          gdAccountID.isAcceptableOrUnknown(
              data['gd_account_i_d']!, _gdAccountIDMeta));
    } else if (isInserting) {
      context.missing(_gdAccountIDMeta);
    }
    if (data.containsKey('rejection_reason')) {
      context.handle(
          _rejectionReasonMeta,
          rejectionReason.isAcceptableOrUnknown(
              data['rejection_reason']!, _rejectionReasonMeta));
    } else if (isInserting) {
      context.missing(_rejectionReasonMeta);
    }
    if (data.containsKey('reviewed_at')) {
      context.handle(
          _reviewedAtMeta,
          reviewedAt.isAcceptableOrUnknown(
              data['reviewed_at']!, _reviewedAtMeta));
    }
    if (data.containsKey('submitted_at')) {
      context.handle(
          _submittedAtMeta,
          submittedAt.isAcceptableOrUnknown(
              data['submitted_at']!, _submittedAtMeta));
    } else if (isInserting) {
      context.missing(_submittedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Submission map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Submission(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      levelID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level_i_d'])!,
      levelVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level_version'])!,
      status: $SubmissionsTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!),
      replayHash: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}replay_hash'])!,
      replayData: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}replay_data']),
      modVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mod_version'])!,
      gdVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gd_version'])!,
      gdAccountID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}gd_account_i_d'])!,
      rejectionReason: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}rejection_reason'])!,
      reviewedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}reviewed_at']),
      submittedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}submitted_at'])!,
    );
  }

  @override
  $SubmissionsTable createAlias(String alias) {
    return $SubmissionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SubmissionStatus, int, int> $converterstatus =
      const EnumIndexConverter<SubmissionStatus>(SubmissionStatus.values);
}

class Submission extends DataClass implements Insertable<Submission> {
  final int id;
  final int levelID;
  final int levelVersion;
  final SubmissionStatus status;
  final Uint8List replayHash;
  final Uint8List? replayData;
  final String modVersion;
  final String gdVersion;
  final int gdAccountID;
  final String rejectionReason;
  final DateTime? reviewedAt;
  final DateTime submittedAt;
  const Submission(
      {required this.id,
      required this.levelID,
      required this.levelVersion,
      required this.status,
      required this.replayHash,
      this.replayData,
      required this.modVersion,
      required this.gdVersion,
      required this.gdAccountID,
      required this.rejectionReason,
      this.reviewedAt,
      required this.submittedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['level_i_d'] = Variable<int>(levelID);
    map['level_version'] = Variable<int>(levelVersion);
    {
      map['status'] =
          Variable<int>($SubmissionsTable.$converterstatus.toSql(status));
    }
    map['replay_hash'] = Variable<Uint8List>(replayHash);
    if (!nullToAbsent || replayData != null) {
      map['replay_data'] = Variable<Uint8List>(replayData);
    }
    map['mod_version'] = Variable<String>(modVersion);
    map['gd_version'] = Variable<String>(gdVersion);
    map['gd_account_i_d'] = Variable<int>(gdAccountID);
    map['rejection_reason'] = Variable<String>(rejectionReason);
    if (!nullToAbsent || reviewedAt != null) {
      map['reviewed_at'] = Variable<DateTime>(reviewedAt);
    }
    map['submitted_at'] = Variable<DateTime>(submittedAt);
    return map;
  }

  SubmissionsCompanion toCompanion(bool nullToAbsent) {
    return SubmissionsCompanion(
      id: Value(id),
      levelID: Value(levelID),
      levelVersion: Value(levelVersion),
      status: Value(status),
      replayHash: Value(replayHash),
      replayData: replayData == null && nullToAbsent
          ? const Value.absent()
          : Value(replayData),
      modVersion: Value(modVersion),
      gdVersion: Value(gdVersion),
      gdAccountID: Value(gdAccountID),
      rejectionReason: Value(rejectionReason),
      reviewedAt: reviewedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(reviewedAt),
      submittedAt: Value(submittedAt),
    );
  }

  factory Submission.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Submission(
      id: serializer.fromJson<int>(json['id']),
      levelID: serializer.fromJson<int>(json['levelID']),
      levelVersion: serializer.fromJson<int>(json['levelVersion']),
      status: $SubmissionsTable.$converterstatus
          .fromJson(serializer.fromJson<int>(json['status'])),
      replayHash: serializer.fromJson<Uint8List>(json['replayHash']),
      replayData: serializer.fromJson<Uint8List?>(json['replayData']),
      modVersion: serializer.fromJson<String>(json['modVersion']),
      gdVersion: serializer.fromJson<String>(json['gdVersion']),
      gdAccountID: serializer.fromJson<int>(json['gdAccountID']),
      rejectionReason: serializer.fromJson<String>(json['rejectionReason']),
      reviewedAt: serializer.fromJson<DateTime?>(json['reviewedAt']),
      submittedAt: serializer.fromJson<DateTime>(json['submittedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'levelID': serializer.toJson<int>(levelID),
      'levelVersion': serializer.toJson<int>(levelVersion),
      'status': serializer
          .toJson<int>($SubmissionsTable.$converterstatus.toJson(status)),
      'replayHash': serializer.toJson<Uint8List>(replayHash),
      'replayData': serializer.toJson<Uint8List?>(replayData),
      'modVersion': serializer.toJson<String>(modVersion),
      'gdVersion': serializer.toJson<String>(gdVersion),
      'gdAccountID': serializer.toJson<int>(gdAccountID),
      'rejectionReason': serializer.toJson<String>(rejectionReason),
      'reviewedAt': serializer.toJson<DateTime?>(reviewedAt),
      'submittedAt': serializer.toJson<DateTime>(submittedAt),
    };
  }

  Submission copyWith(
          {int? id,
          int? levelID,
          int? levelVersion,
          SubmissionStatus? status,
          Uint8List? replayHash,
          Value<Uint8List?> replayData = const Value.absent(),
          String? modVersion,
          String? gdVersion,
          int? gdAccountID,
          String? rejectionReason,
          Value<DateTime?> reviewedAt = const Value.absent(),
          DateTime? submittedAt}) =>
      Submission(
        id: id ?? this.id,
        levelID: levelID ?? this.levelID,
        levelVersion: levelVersion ?? this.levelVersion,
        status: status ?? this.status,
        replayHash: replayHash ?? this.replayHash,
        replayData: replayData.present ? replayData.value : this.replayData,
        modVersion: modVersion ?? this.modVersion,
        gdVersion: gdVersion ?? this.gdVersion,
        gdAccountID: gdAccountID ?? this.gdAccountID,
        rejectionReason: rejectionReason ?? this.rejectionReason,
        reviewedAt: reviewedAt.present ? reviewedAt.value : this.reviewedAt,
        submittedAt: submittedAt ?? this.submittedAt,
      );
  Submission copyWithCompanion(SubmissionsCompanion data) {
    return Submission(
      id: data.id.present ? data.id.value : this.id,
      levelID: data.levelID.present ? data.levelID.value : this.levelID,
      levelVersion: data.levelVersion.present
          ? data.levelVersion.value
          : this.levelVersion,
      status: data.status.present ? data.status.value : this.status,
      replayHash:
          data.replayHash.present ? data.replayHash.value : this.replayHash,
      replayData:
          data.replayData.present ? data.replayData.value : this.replayData,
      modVersion:
          data.modVersion.present ? data.modVersion.value : this.modVersion,
      gdVersion: data.gdVersion.present ? data.gdVersion.value : this.gdVersion,
      gdAccountID:
          data.gdAccountID.present ? data.gdAccountID.value : this.gdAccountID,
      rejectionReason: data.rejectionReason.present
          ? data.rejectionReason.value
          : this.rejectionReason,
      reviewedAt:
          data.reviewedAt.present ? data.reviewedAt.value : this.reviewedAt,
      submittedAt:
          data.submittedAt.present ? data.submittedAt.value : this.submittedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Submission(')
          ..write('id: $id, ')
          ..write('levelID: $levelID, ')
          ..write('levelVersion: $levelVersion, ')
          ..write('status: $status, ')
          ..write('replayHash: $replayHash, ')
          ..write('replayData: $replayData, ')
          ..write('modVersion: $modVersion, ')
          ..write('gdVersion: $gdVersion, ')
          ..write('gdAccountID: $gdAccountID, ')
          ..write('rejectionReason: $rejectionReason, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('submittedAt: $submittedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      levelID,
      levelVersion,
      status,
      $driftBlobEquality.hash(replayHash),
      $driftBlobEquality.hash(replayData),
      modVersion,
      gdVersion,
      gdAccountID,
      rejectionReason,
      reviewedAt,
      submittedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Submission &&
          other.id == this.id &&
          other.levelID == this.levelID &&
          other.levelVersion == this.levelVersion &&
          other.status == this.status &&
          $driftBlobEquality.equals(other.replayHash, this.replayHash) &&
          $driftBlobEquality.equals(other.replayData, this.replayData) &&
          other.modVersion == this.modVersion &&
          other.gdVersion == this.gdVersion &&
          other.gdAccountID == this.gdAccountID &&
          other.rejectionReason == this.rejectionReason &&
          other.reviewedAt == this.reviewedAt &&
          other.submittedAt == this.submittedAt);
}

class SubmissionsCompanion extends UpdateCompanion<Submission> {
  final Value<int> id;
  final Value<int> levelID;
  final Value<int> levelVersion;
  final Value<SubmissionStatus> status;
  final Value<Uint8List> replayHash;
  final Value<Uint8List?> replayData;
  final Value<String> modVersion;
  final Value<String> gdVersion;
  final Value<int> gdAccountID;
  final Value<String> rejectionReason;
  final Value<DateTime?> reviewedAt;
  final Value<DateTime> submittedAt;
  const SubmissionsCompanion({
    this.id = const Value.absent(),
    this.levelID = const Value.absent(),
    this.levelVersion = const Value.absent(),
    this.status = const Value.absent(),
    this.replayHash = const Value.absent(),
    this.replayData = const Value.absent(),
    this.modVersion = const Value.absent(),
    this.gdVersion = const Value.absent(),
    this.gdAccountID = const Value.absent(),
    this.rejectionReason = const Value.absent(),
    this.reviewedAt = const Value.absent(),
    this.submittedAt = const Value.absent(),
  });
  SubmissionsCompanion.insert({
    this.id = const Value.absent(),
    required int levelID,
    required int levelVersion,
    required SubmissionStatus status,
    required Uint8List replayHash,
    this.replayData = const Value.absent(),
    required String modVersion,
    required String gdVersion,
    required int gdAccountID,
    required String rejectionReason,
    this.reviewedAt = const Value.absent(),
    required DateTime submittedAt,
  })  : levelID = Value(levelID),
        levelVersion = Value(levelVersion),
        status = Value(status),
        replayHash = Value(replayHash),
        modVersion = Value(modVersion),
        gdVersion = Value(gdVersion),
        gdAccountID = Value(gdAccountID),
        rejectionReason = Value(rejectionReason),
        submittedAt = Value(submittedAt);
  static Insertable<Submission> custom({
    Expression<int>? id,
    Expression<int>? levelID,
    Expression<int>? levelVersion,
    Expression<int>? status,
    Expression<Uint8List>? replayHash,
    Expression<Uint8List>? replayData,
    Expression<String>? modVersion,
    Expression<String>? gdVersion,
    Expression<int>? gdAccountID,
    Expression<String>? rejectionReason,
    Expression<DateTime>? reviewedAt,
    Expression<DateTime>? submittedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (levelID != null) 'level_i_d': levelID,
      if (levelVersion != null) 'level_version': levelVersion,
      if (status != null) 'status': status,
      if (replayHash != null) 'replay_hash': replayHash,
      if (replayData != null) 'replay_data': replayData,
      if (modVersion != null) 'mod_version': modVersion,
      if (gdVersion != null) 'gd_version': gdVersion,
      if (gdAccountID != null) 'gd_account_i_d': gdAccountID,
      if (rejectionReason != null) 'rejection_reason': rejectionReason,
      if (reviewedAt != null) 'reviewed_at': reviewedAt,
      if (submittedAt != null) 'submitted_at': submittedAt,
    });
  }

  SubmissionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? levelID,
      Value<int>? levelVersion,
      Value<SubmissionStatus>? status,
      Value<Uint8List>? replayHash,
      Value<Uint8List?>? replayData,
      Value<String>? modVersion,
      Value<String>? gdVersion,
      Value<int>? gdAccountID,
      Value<String>? rejectionReason,
      Value<DateTime?>? reviewedAt,
      Value<DateTime>? submittedAt}) {
    return SubmissionsCompanion(
      id: id ?? this.id,
      levelID: levelID ?? this.levelID,
      levelVersion: levelVersion ?? this.levelVersion,
      status: status ?? this.status,
      replayHash: replayHash ?? this.replayHash,
      replayData: replayData ?? this.replayData,
      modVersion: modVersion ?? this.modVersion,
      gdVersion: gdVersion ?? this.gdVersion,
      gdAccountID: gdAccountID ?? this.gdAccountID,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      submittedAt: submittedAt ?? this.submittedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (levelID.present) {
      map['level_i_d'] = Variable<int>(levelID.value);
    }
    if (levelVersion.present) {
      map['level_version'] = Variable<int>(levelVersion.value);
    }
    if (status.present) {
      map['status'] =
          Variable<int>($SubmissionsTable.$converterstatus.toSql(status.value));
    }
    if (replayHash.present) {
      map['replay_hash'] = Variable<Uint8List>(replayHash.value);
    }
    if (replayData.present) {
      map['replay_data'] = Variable<Uint8List>(replayData.value);
    }
    if (modVersion.present) {
      map['mod_version'] = Variable<String>(modVersion.value);
    }
    if (gdVersion.present) {
      map['gd_version'] = Variable<String>(gdVersion.value);
    }
    if (gdAccountID.present) {
      map['gd_account_i_d'] = Variable<int>(gdAccountID.value);
    }
    if (rejectionReason.present) {
      map['rejection_reason'] = Variable<String>(rejectionReason.value);
    }
    if (reviewedAt.present) {
      map['reviewed_at'] = Variable<DateTime>(reviewedAt.value);
    }
    if (submittedAt.present) {
      map['submitted_at'] = Variable<DateTime>(submittedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubmissionsCompanion(')
          ..write('id: $id, ')
          ..write('levelID: $levelID, ')
          ..write('levelVersion: $levelVersion, ')
          ..write('status: $status, ')
          ..write('replayHash: $replayHash, ')
          ..write('replayData: $replayData, ')
          ..write('modVersion: $modVersion, ')
          ..write('gdVersion: $gdVersion, ')
          ..write('gdAccountID: $gdAccountID, ')
          ..write('rejectionReason: $rejectionReason, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('submittedAt: $submittedAt')
          ..write(')'))
        .toString();
  }
}

class $AccessesTable extends Accesses
    with TableInfo<$AccessesTable, AccessesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccessesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _accessIDMeta =
      const VerificationMeta('accessID');
  @override
  late final GeneratedColumn<int> accessID = GeneratedColumn<int>(
      'access_i_d', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _gdAccountIDMeta =
      const VerificationMeta('gdAccountID');
  @override
  late final GeneratedColumn<int> gdAccountID = GeneratedColumn<int>(
      'gd_account_i_d', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (account_i_d)'));
  static const VerificationMeta _levelIDMeta =
      const VerificationMeta('levelID');
  @override
  late final GeneratedColumn<int> levelID = GeneratedColumn<int>(
      'level_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES levels (level_i_d)'));
  static const VerificationMeta _accessTimeMeta =
      const VerificationMeta('accessTime');
  @override
  late final GeneratedColumn<DateTime> accessTime = GeneratedColumn<DateTime>(
      'access_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [accessID, gdAccountID, levelID, accessTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accesses';
  @override
  VerificationContext validateIntegrity(Insertable<AccessesData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('access_i_d')) {
      context.handle(_accessIDMeta,
          accessID.isAcceptableOrUnknown(data['access_i_d']!, _accessIDMeta));
    }
    if (data.containsKey('gd_account_i_d')) {
      context.handle(
          _gdAccountIDMeta,
          gdAccountID.isAcceptableOrUnknown(
              data['gd_account_i_d']!, _gdAccountIDMeta));
    }
    if (data.containsKey('level_i_d')) {
      context.handle(_levelIDMeta,
          levelID.isAcceptableOrUnknown(data['level_i_d']!, _levelIDMeta));
    } else if (isInserting) {
      context.missing(_levelIDMeta);
    }
    if (data.containsKey('access_time')) {
      context.handle(
          _accessTimeMeta,
          accessTime.isAcceptableOrUnknown(
              data['access_time']!, _accessTimeMeta));
    } else if (isInserting) {
      context.missing(_accessTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {accessID};
  @override
  AccessesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccessesData(
      accessID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}access_i_d'])!,
      gdAccountID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}gd_account_i_d']),
      levelID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level_i_d'])!,
      accessTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}access_time'])!,
    );
  }

  @override
  $AccessesTable createAlias(String alias) {
    return $AccessesTable(attachedDatabase, alias);
  }
}

class AccessesData extends DataClass implements Insertable<AccessesData> {
  final int accessID;
  final int? gdAccountID;
  final int levelID;
  final DateTime accessTime;
  const AccessesData(
      {required this.accessID,
      this.gdAccountID,
      required this.levelID,
      required this.accessTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['access_i_d'] = Variable<int>(accessID);
    if (!nullToAbsent || gdAccountID != null) {
      map['gd_account_i_d'] = Variable<int>(gdAccountID);
    }
    map['level_i_d'] = Variable<int>(levelID);
    map['access_time'] = Variable<DateTime>(accessTime);
    return map;
  }

  AccessesCompanion toCompanion(bool nullToAbsent) {
    return AccessesCompanion(
      accessID: Value(accessID),
      gdAccountID: gdAccountID == null && nullToAbsent
          ? const Value.absent()
          : Value(gdAccountID),
      levelID: Value(levelID),
      accessTime: Value(accessTime),
    );
  }

  factory AccessesData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccessesData(
      accessID: serializer.fromJson<int>(json['accessID']),
      gdAccountID: serializer.fromJson<int?>(json['gdAccountID']),
      levelID: serializer.fromJson<int>(json['levelID']),
      accessTime: serializer.fromJson<DateTime>(json['accessTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accessID': serializer.toJson<int>(accessID),
      'gdAccountID': serializer.toJson<int?>(gdAccountID),
      'levelID': serializer.toJson<int>(levelID),
      'accessTime': serializer.toJson<DateTime>(accessTime),
    };
  }

  AccessesData copyWith(
          {int? accessID,
          Value<int?> gdAccountID = const Value.absent(),
          int? levelID,
          DateTime? accessTime}) =>
      AccessesData(
        accessID: accessID ?? this.accessID,
        gdAccountID: gdAccountID.present ? gdAccountID.value : this.gdAccountID,
        levelID: levelID ?? this.levelID,
        accessTime: accessTime ?? this.accessTime,
      );
  AccessesData copyWithCompanion(AccessesCompanion data) {
    return AccessesData(
      accessID: data.accessID.present ? data.accessID.value : this.accessID,
      gdAccountID:
          data.gdAccountID.present ? data.gdAccountID.value : this.gdAccountID,
      levelID: data.levelID.present ? data.levelID.value : this.levelID,
      accessTime:
          data.accessTime.present ? data.accessTime.value : this.accessTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccessesData(')
          ..write('accessID: $accessID, ')
          ..write('gdAccountID: $gdAccountID, ')
          ..write('levelID: $levelID, ')
          ..write('accessTime: $accessTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(accessID, gdAccountID, levelID, accessTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccessesData &&
          other.accessID == this.accessID &&
          other.gdAccountID == this.gdAccountID &&
          other.levelID == this.levelID &&
          other.accessTime == this.accessTime);
}

class AccessesCompanion extends UpdateCompanion<AccessesData> {
  final Value<int> accessID;
  final Value<int?> gdAccountID;
  final Value<int> levelID;
  final Value<DateTime> accessTime;
  const AccessesCompanion({
    this.accessID = const Value.absent(),
    this.gdAccountID = const Value.absent(),
    this.levelID = const Value.absent(),
    this.accessTime = const Value.absent(),
  });
  AccessesCompanion.insert({
    this.accessID = const Value.absent(),
    this.gdAccountID = const Value.absent(),
    required int levelID,
    required DateTime accessTime,
  })  : levelID = Value(levelID),
        accessTime = Value(accessTime);
  static Insertable<AccessesData> custom({
    Expression<int>? accessID,
    Expression<int>? gdAccountID,
    Expression<int>? levelID,
    Expression<DateTime>? accessTime,
  }) {
    return RawValuesInsertable({
      if (accessID != null) 'access_i_d': accessID,
      if (gdAccountID != null) 'gd_account_i_d': gdAccountID,
      if (levelID != null) 'level_i_d': levelID,
      if (accessTime != null) 'access_time': accessTime,
    });
  }

  AccessesCompanion copyWith(
      {Value<int>? accessID,
      Value<int?>? gdAccountID,
      Value<int>? levelID,
      Value<DateTime>? accessTime}) {
    return AccessesCompanion(
      accessID: accessID ?? this.accessID,
      gdAccountID: gdAccountID ?? this.gdAccountID,
      levelID: levelID ?? this.levelID,
      accessTime: accessTime ?? this.accessTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accessID.present) {
      map['access_i_d'] = Variable<int>(accessID.value);
    }
    if (gdAccountID.present) {
      map['gd_account_i_d'] = Variable<int>(gdAccountID.value);
    }
    if (levelID.present) {
      map['level_i_d'] = Variable<int>(levelID.value);
    }
    if (accessTime.present) {
      map['access_time'] = Variable<DateTime>(accessTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccessesCompanion(')
          ..write('accessID: $accessID, ')
          ..write('gdAccountID: $gdAccountID, ')
          ..write('levelID: $levelID, ')
          ..write('accessTime: $accessTime')
          ..write(')'))
        .toString();
  }
}

abstract class _$ShowcaseDatabase extends GeneratedDatabase {
  _$ShowcaseDatabase(QueryExecutor e) : super(e);
  $ShowcaseDatabaseManager get managers => $ShowcaseDatabaseManager(this);
  late final $LevelsTable levels = $LevelsTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $SubmissionsTable submissions = $SubmissionsTable(this);
  late final $AccessesTable accesses = $AccessesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [levels, users, submissions, accesses];
}

typedef $$LevelsTableCreateCompanionBuilder = LevelsCompanion Function({
  required int levelID,
  Value<String?> cachedTitle,
  Value<String?> cachedCreator,
  Value<String?> cachedDescription,
  Value<int?> cachedVersion,
  Value<int?> cachedStars,
  Value<LevelDifficulty?> cachedDifficulty,
  Value<int?> cachedLikes,
  required DateTime lastCacheUpdateAt,
  Value<int> accesses,
  Value<int> rowid,
});
typedef $$LevelsTableUpdateCompanionBuilder = LevelsCompanion Function({
  Value<int> levelID,
  Value<String?> cachedTitle,
  Value<String?> cachedCreator,
  Value<String?> cachedDescription,
  Value<int?> cachedVersion,
  Value<int?> cachedStars,
  Value<LevelDifficulty?> cachedDifficulty,
  Value<int?> cachedLikes,
  Value<DateTime> lastCacheUpdateAt,
  Value<int> accesses,
  Value<int> rowid,
});

final class $$LevelsTableReferences
    extends BaseReferences<_$ShowcaseDatabase, $LevelsTable, Level> {
  $$LevelsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SubmissionsTable, List<Submission>>
      _submissionsRefsTable(_$ShowcaseDatabase db) =>
          MultiTypedResultKey.fromTable(db.submissions,
              aliasName: $_aliasNameGenerator(
                  db.levels.levelID, db.submissions.levelID));

  $$SubmissionsTableProcessedTableManager get submissionsRefs {
    final manager = $$SubmissionsTableTableManager($_db, $_db.submissions)
        .filter((f) =>
            f.levelID.levelID.sqlEquals($_itemColumn<int>('level_i_d')!));

    final cache = $_typedResult.readTableOrNull(_submissionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AccessesTable, List<AccessesData>>
      _accessesRefsTable(_$ShowcaseDatabase db) =>
          MultiTypedResultKey.fromTable(db.accesses,
              aliasName:
                  $_aliasNameGenerator(db.levels.levelID, db.accesses.levelID));

  $$AccessesTableProcessedTableManager get accessesRefs {
    final manager = $$AccessesTableTableManager($_db, $_db.accesses).filter(
        (f) => f.levelID.levelID.sqlEquals($_itemColumn<int>('level_i_d')!));

    final cache = $_typedResult.readTableOrNull(_accessesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LevelsTableFilterComposer
    extends Composer<_$ShowcaseDatabase, $LevelsTable> {
  $$LevelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get levelID => $composableBuilder(
      column: $table.levelID, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cachedTitle => $composableBuilder(
      column: $table.cachedTitle, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cachedCreator => $composableBuilder(
      column: $table.cachedCreator, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cachedDescription => $composableBuilder(
      column: $table.cachedDescription,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cachedVersion => $composableBuilder(
      column: $table.cachedVersion, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cachedStars => $composableBuilder(
      column: $table.cachedStars, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<LevelDifficulty?, LevelDifficulty, int>
      get cachedDifficulty => $composableBuilder(
          column: $table.cachedDifficulty,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get cachedLikes => $composableBuilder(
      column: $table.cachedLikes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastCacheUpdateAt => $composableBuilder(
      column: $table.lastCacheUpdateAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get accesses => $composableBuilder(
      column: $table.accesses, builder: (column) => ColumnFilters(column));

  Expression<bool> submissionsRefs(
      Expression<bool> Function($$SubmissionsTableFilterComposer f) f) {
    final $$SubmissionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.levelID,
        referencedTable: $db.submissions,
        getReferencedColumn: (t) => t.levelID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubmissionsTableFilterComposer(
              $db: $db,
              $table: $db.submissions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> accessesRefs(
      Expression<bool> Function($$AccessesTableFilterComposer f) f) {
    final $$AccessesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.levelID,
        referencedTable: $db.accesses,
        getReferencedColumn: (t) => t.levelID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccessesTableFilterComposer(
              $db: $db,
              $table: $db.accesses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LevelsTableOrderingComposer
    extends Composer<_$ShowcaseDatabase, $LevelsTable> {
  $$LevelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get levelID => $composableBuilder(
      column: $table.levelID, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cachedTitle => $composableBuilder(
      column: $table.cachedTitle, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cachedCreator => $composableBuilder(
      column: $table.cachedCreator,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cachedDescription => $composableBuilder(
      column: $table.cachedDescription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cachedVersion => $composableBuilder(
      column: $table.cachedVersion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cachedStars => $composableBuilder(
      column: $table.cachedStars, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cachedDifficulty => $composableBuilder(
      column: $table.cachedDifficulty,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cachedLikes => $composableBuilder(
      column: $table.cachedLikes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastCacheUpdateAt => $composableBuilder(
      column: $table.lastCacheUpdateAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get accesses => $composableBuilder(
      column: $table.accesses, builder: (column) => ColumnOrderings(column));
}

class $$LevelsTableAnnotationComposer
    extends Composer<_$ShowcaseDatabase, $LevelsTable> {
  $$LevelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get levelID =>
      $composableBuilder(column: $table.levelID, builder: (column) => column);

  GeneratedColumn<String> get cachedTitle => $composableBuilder(
      column: $table.cachedTitle, builder: (column) => column);

  GeneratedColumn<String> get cachedCreator => $composableBuilder(
      column: $table.cachedCreator, builder: (column) => column);

  GeneratedColumn<String> get cachedDescription => $composableBuilder(
      column: $table.cachedDescription, builder: (column) => column);

  GeneratedColumn<int> get cachedVersion => $composableBuilder(
      column: $table.cachedVersion, builder: (column) => column);

  GeneratedColumn<int> get cachedStars => $composableBuilder(
      column: $table.cachedStars, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LevelDifficulty?, int>
      get cachedDifficulty => $composableBuilder(
          column: $table.cachedDifficulty, builder: (column) => column);

  GeneratedColumn<int> get cachedLikes => $composableBuilder(
      column: $table.cachedLikes, builder: (column) => column);

  GeneratedColumn<DateTime> get lastCacheUpdateAt => $composableBuilder(
      column: $table.lastCacheUpdateAt, builder: (column) => column);

  GeneratedColumn<int> get accesses =>
      $composableBuilder(column: $table.accesses, builder: (column) => column);

  Expression<T> submissionsRefs<T extends Object>(
      Expression<T> Function($$SubmissionsTableAnnotationComposer a) f) {
    final $$SubmissionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.levelID,
        referencedTable: $db.submissions,
        getReferencedColumn: (t) => t.levelID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubmissionsTableAnnotationComposer(
              $db: $db,
              $table: $db.submissions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> accessesRefs<T extends Object>(
      Expression<T> Function($$AccessesTableAnnotationComposer a) f) {
    final $$AccessesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.levelID,
        referencedTable: $db.accesses,
        getReferencedColumn: (t) => t.levelID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccessesTableAnnotationComposer(
              $db: $db,
              $table: $db.accesses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LevelsTableTableManager extends RootTableManager<
    _$ShowcaseDatabase,
    $LevelsTable,
    Level,
    $$LevelsTableFilterComposer,
    $$LevelsTableOrderingComposer,
    $$LevelsTableAnnotationComposer,
    $$LevelsTableCreateCompanionBuilder,
    $$LevelsTableUpdateCompanionBuilder,
    (Level, $$LevelsTableReferences),
    Level,
    PrefetchHooks Function({bool submissionsRefs, bool accessesRefs})> {
  $$LevelsTableTableManager(_$ShowcaseDatabase db, $LevelsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LevelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LevelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LevelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> levelID = const Value.absent(),
            Value<String?> cachedTitle = const Value.absent(),
            Value<String?> cachedCreator = const Value.absent(),
            Value<String?> cachedDescription = const Value.absent(),
            Value<int?> cachedVersion = const Value.absent(),
            Value<int?> cachedStars = const Value.absent(),
            Value<LevelDifficulty?> cachedDifficulty = const Value.absent(),
            Value<int?> cachedLikes = const Value.absent(),
            Value<DateTime> lastCacheUpdateAt = const Value.absent(),
            Value<int> accesses = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LevelsCompanion(
            levelID: levelID,
            cachedTitle: cachedTitle,
            cachedCreator: cachedCreator,
            cachedDescription: cachedDescription,
            cachedVersion: cachedVersion,
            cachedStars: cachedStars,
            cachedDifficulty: cachedDifficulty,
            cachedLikes: cachedLikes,
            lastCacheUpdateAt: lastCacheUpdateAt,
            accesses: accesses,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int levelID,
            Value<String?> cachedTitle = const Value.absent(),
            Value<String?> cachedCreator = const Value.absent(),
            Value<String?> cachedDescription = const Value.absent(),
            Value<int?> cachedVersion = const Value.absent(),
            Value<int?> cachedStars = const Value.absent(),
            Value<LevelDifficulty?> cachedDifficulty = const Value.absent(),
            Value<int?> cachedLikes = const Value.absent(),
            required DateTime lastCacheUpdateAt,
            Value<int> accesses = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LevelsCompanion.insert(
            levelID: levelID,
            cachedTitle: cachedTitle,
            cachedCreator: cachedCreator,
            cachedDescription: cachedDescription,
            cachedVersion: cachedVersion,
            cachedStars: cachedStars,
            cachedDifficulty: cachedDifficulty,
            cachedLikes: cachedLikes,
            lastCacheUpdateAt: lastCacheUpdateAt,
            accesses: accesses,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$LevelsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {submissionsRefs = false, accessesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (submissionsRefs) db.submissions,
                if (accessesRefs) db.accesses
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (submissionsRefs)
                    await $_getPrefetchedData<Level, $LevelsTable, Submission>(
                        currentTable: table,
                        referencedTable:
                            $$LevelsTableReferences._submissionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LevelsTableReferences(db, table, p0)
                                .submissionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.levelID == item.levelID),
                        typedResults: items),
                  if (accessesRefs)
                    await $_getPrefetchedData<Level, $LevelsTable,
                            AccessesData>(
                        currentTable: table,
                        referencedTable:
                            $$LevelsTableReferences._accessesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LevelsTableReferences(db, table, p0).accessesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.levelID == item.levelID),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LevelsTableProcessedTableManager = ProcessedTableManager<
    _$ShowcaseDatabase,
    $LevelsTable,
    Level,
    $$LevelsTableFilterComposer,
    $$LevelsTableOrderingComposer,
    $$LevelsTableAnnotationComposer,
    $$LevelsTableCreateCompanionBuilder,
    $$LevelsTableUpdateCompanionBuilder,
    (Level, $$LevelsTableReferences),
    Level,
    PrefetchHooks Function({bool submissionsRefs, bool accessesRefs})>;
typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  required int accountID,
  required String cachedUsername,
  required int badPoints,
  required String badPointsLog,
  required DateTime lastCacheUpdateAt,
  Value<int> rowid,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> accountID,
  Value<String> cachedUsername,
  Value<int> badPoints,
  Value<String> badPointsLog,
  Value<DateTime> lastCacheUpdateAt,
  Value<int> rowid,
});

final class $$UsersTableReferences
    extends BaseReferences<_$ShowcaseDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SubmissionsTable, List<Submission>>
      _submissionsRefsTable(_$ShowcaseDatabase db) =>
          MultiTypedResultKey.fromTable(db.submissions,
              aliasName: $_aliasNameGenerator(
                  db.users.accountID, db.submissions.gdAccountID));

  $$SubmissionsTableProcessedTableManager get submissionsRefs {
    final manager = $$SubmissionsTableTableManager($_db, $_db.submissions)
        .filter((f) => f.gdAccountID.accountID
            .sqlEquals($_itemColumn<int>('account_i_d')!));

    final cache = $_typedResult.readTableOrNull(_submissionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AccessesTable, List<AccessesData>>
      _accessesRefsTable(_$ShowcaseDatabase db) =>
          MultiTypedResultKey.fromTable(db.accesses,
              aliasName: $_aliasNameGenerator(
                  db.users.accountID, db.accesses.gdAccountID));

  $$AccessesTableProcessedTableManager get accessesRefs {
    final manager = $$AccessesTableTableManager($_db, $_db.accesses).filter(
        (f) => f.gdAccountID.accountID
            .sqlEquals($_itemColumn<int>('account_i_d')!));

    final cache = $_typedResult.readTableOrNull(_accessesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UsersTableFilterComposer
    extends Composer<_$ShowcaseDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get accountID => $composableBuilder(
      column: $table.accountID, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cachedUsername => $composableBuilder(
      column: $table.cachedUsername,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get badPoints => $composableBuilder(
      column: $table.badPoints, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get badPointsLog => $composableBuilder(
      column: $table.badPointsLog, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastCacheUpdateAt => $composableBuilder(
      column: $table.lastCacheUpdateAt,
      builder: (column) => ColumnFilters(column));

  Expression<bool> submissionsRefs(
      Expression<bool> Function($$SubmissionsTableFilterComposer f) f) {
    final $$SubmissionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.accountID,
        referencedTable: $db.submissions,
        getReferencedColumn: (t) => t.gdAccountID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubmissionsTableFilterComposer(
              $db: $db,
              $table: $db.submissions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> accessesRefs(
      Expression<bool> Function($$AccessesTableFilterComposer f) f) {
    final $$AccessesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.accountID,
        referencedTable: $db.accesses,
        getReferencedColumn: (t) => t.gdAccountID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccessesTableFilterComposer(
              $db: $db,
              $table: $db.accesses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$ShowcaseDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get accountID => $composableBuilder(
      column: $table.accountID, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cachedUsername => $composableBuilder(
      column: $table.cachedUsername,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get badPoints => $composableBuilder(
      column: $table.badPoints, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get badPointsLog => $composableBuilder(
      column: $table.badPointsLog,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastCacheUpdateAt => $composableBuilder(
      column: $table.lastCacheUpdateAt,
      builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$ShowcaseDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get accountID =>
      $composableBuilder(column: $table.accountID, builder: (column) => column);

  GeneratedColumn<String> get cachedUsername => $composableBuilder(
      column: $table.cachedUsername, builder: (column) => column);

  GeneratedColumn<int> get badPoints =>
      $composableBuilder(column: $table.badPoints, builder: (column) => column);

  GeneratedColumn<String> get badPointsLog => $composableBuilder(
      column: $table.badPointsLog, builder: (column) => column);

  GeneratedColumn<DateTime> get lastCacheUpdateAt => $composableBuilder(
      column: $table.lastCacheUpdateAt, builder: (column) => column);

  Expression<T> submissionsRefs<T extends Object>(
      Expression<T> Function($$SubmissionsTableAnnotationComposer a) f) {
    final $$SubmissionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.accountID,
        referencedTable: $db.submissions,
        getReferencedColumn: (t) => t.gdAccountID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubmissionsTableAnnotationComposer(
              $db: $db,
              $table: $db.submissions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> accessesRefs<T extends Object>(
      Expression<T> Function($$AccessesTableAnnotationComposer a) f) {
    final $$AccessesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.accountID,
        referencedTable: $db.accesses,
        getReferencedColumn: (t) => t.gdAccountID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccessesTableAnnotationComposer(
              $db: $db,
              $table: $db.accesses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableTableManager extends RootTableManager<
    _$ShowcaseDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function({bool submissionsRefs, bool accessesRefs})> {
  $$UsersTableTableManager(_$ShowcaseDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> accountID = const Value.absent(),
            Value<String> cachedUsername = const Value.absent(),
            Value<int> badPoints = const Value.absent(),
            Value<String> badPointsLog = const Value.absent(),
            Value<DateTime> lastCacheUpdateAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersCompanion(
            accountID: accountID,
            cachedUsername: cachedUsername,
            badPoints: badPoints,
            badPointsLog: badPointsLog,
            lastCacheUpdateAt: lastCacheUpdateAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int accountID,
            required String cachedUsername,
            required int badPoints,
            required String badPointsLog,
            required DateTime lastCacheUpdateAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            accountID: accountID,
            cachedUsername: cachedUsername,
            badPoints: badPoints,
            badPointsLog: badPointsLog,
            lastCacheUpdateAt: lastCacheUpdateAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$UsersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {submissionsRefs = false, accessesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (submissionsRefs) db.submissions,
                if (accessesRefs) db.accesses
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (submissionsRefs)
                    await $_getPrefetchedData<User, $UsersTable, Submission>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._submissionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .submissionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.gdAccountID == item.accountID),
                        typedResults: items),
                  if (accessesRefs)
                    await $_getPrefetchedData<User, $UsersTable, AccessesData>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._accessesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0).accessesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.gdAccountID == item.accountID),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$ShowcaseDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function({bool submissionsRefs, bool accessesRefs})>;
typedef $$SubmissionsTableCreateCompanionBuilder = SubmissionsCompanion
    Function({
  Value<int> id,
  required int levelID,
  required int levelVersion,
  required SubmissionStatus status,
  required Uint8List replayHash,
  Value<Uint8List?> replayData,
  required String modVersion,
  required String gdVersion,
  required int gdAccountID,
  required String rejectionReason,
  Value<DateTime?> reviewedAt,
  required DateTime submittedAt,
});
typedef $$SubmissionsTableUpdateCompanionBuilder = SubmissionsCompanion
    Function({
  Value<int> id,
  Value<int> levelID,
  Value<int> levelVersion,
  Value<SubmissionStatus> status,
  Value<Uint8List> replayHash,
  Value<Uint8List?> replayData,
  Value<String> modVersion,
  Value<String> gdVersion,
  Value<int> gdAccountID,
  Value<String> rejectionReason,
  Value<DateTime?> reviewedAt,
  Value<DateTime> submittedAt,
});

final class $$SubmissionsTableReferences
    extends BaseReferences<_$ShowcaseDatabase, $SubmissionsTable, Submission> {
  $$SubmissionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LevelsTable _levelIDTable(_$ShowcaseDatabase db) =>
      db.levels.createAlias(
          $_aliasNameGenerator(db.submissions.levelID, db.levels.levelID));

  $$LevelsTableProcessedTableManager get levelID {
    final $_column = $_itemColumn<int>('level_i_d')!;

    final manager = $$LevelsTableTableManager($_db, $_db.levels)
        .filter((f) => f.levelID.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_levelIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsersTable _gdAccountIDTable(_$ShowcaseDatabase db) =>
      db.users.createAlias(
          $_aliasNameGenerator(db.submissions.gdAccountID, db.users.accountID));

  $$UsersTableProcessedTableManager get gdAccountID {
    final $_column = $_itemColumn<int>('gd_account_i_d')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.accountID.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gdAccountIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SubmissionsTableFilterComposer
    extends Composer<_$ShowcaseDatabase, $SubmissionsTable> {
  $$SubmissionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get levelVersion => $composableBuilder(
      column: $table.levelVersion, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<SubmissionStatus, SubmissionStatus, int>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<Uint8List> get replayHash => $composableBuilder(
      column: $table.replayHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<Uint8List> get replayData => $composableBuilder(
      column: $table.replayData, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get modVersion => $composableBuilder(
      column: $table.modVersion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gdVersion => $composableBuilder(
      column: $table.gdVersion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rejectionReason => $composableBuilder(
      column: $table.rejectionReason,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get reviewedAt => $composableBuilder(
      column: $table.reviewedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get submittedAt => $composableBuilder(
      column: $table.submittedAt, builder: (column) => ColumnFilters(column));

  $$LevelsTableFilterComposer get levelID {
    final $$LevelsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.levelID,
        referencedTable: $db.levels,
        getReferencedColumn: (t) => t.levelID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LevelsTableFilterComposer(
              $db: $db,
              $table: $db.levels,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableFilterComposer get gdAccountID {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.gdAccountID,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.accountID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SubmissionsTableOrderingComposer
    extends Composer<_$ShowcaseDatabase, $SubmissionsTable> {
  $$SubmissionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get levelVersion => $composableBuilder(
      column: $table.levelVersion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<Uint8List> get replayHash => $composableBuilder(
      column: $table.replayHash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<Uint8List> get replayData => $composableBuilder(
      column: $table.replayData, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get modVersion => $composableBuilder(
      column: $table.modVersion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gdVersion => $composableBuilder(
      column: $table.gdVersion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rejectionReason => $composableBuilder(
      column: $table.rejectionReason,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get reviewedAt => $composableBuilder(
      column: $table.reviewedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get submittedAt => $composableBuilder(
      column: $table.submittedAt, builder: (column) => ColumnOrderings(column));

  $$LevelsTableOrderingComposer get levelID {
    final $$LevelsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.levelID,
        referencedTable: $db.levels,
        getReferencedColumn: (t) => t.levelID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LevelsTableOrderingComposer(
              $db: $db,
              $table: $db.levels,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableOrderingComposer get gdAccountID {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.gdAccountID,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.accountID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SubmissionsTableAnnotationComposer
    extends Composer<_$ShowcaseDatabase, $SubmissionsTable> {
  $$SubmissionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get levelVersion => $composableBuilder(
      column: $table.levelVersion, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SubmissionStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<Uint8List> get replayHash => $composableBuilder(
      column: $table.replayHash, builder: (column) => column);

  GeneratedColumn<Uint8List> get replayData => $composableBuilder(
      column: $table.replayData, builder: (column) => column);

  GeneratedColumn<String> get modVersion => $composableBuilder(
      column: $table.modVersion, builder: (column) => column);

  GeneratedColumn<String> get gdVersion =>
      $composableBuilder(column: $table.gdVersion, builder: (column) => column);

  GeneratedColumn<String> get rejectionReason => $composableBuilder(
      column: $table.rejectionReason, builder: (column) => column);

  GeneratedColumn<DateTime> get reviewedAt => $composableBuilder(
      column: $table.reviewedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get submittedAt => $composableBuilder(
      column: $table.submittedAt, builder: (column) => column);

  $$LevelsTableAnnotationComposer get levelID {
    final $$LevelsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.levelID,
        referencedTable: $db.levels,
        getReferencedColumn: (t) => t.levelID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LevelsTableAnnotationComposer(
              $db: $db,
              $table: $db.levels,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableAnnotationComposer get gdAccountID {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.gdAccountID,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.accountID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SubmissionsTableTableManager extends RootTableManager<
    _$ShowcaseDatabase,
    $SubmissionsTable,
    Submission,
    $$SubmissionsTableFilterComposer,
    $$SubmissionsTableOrderingComposer,
    $$SubmissionsTableAnnotationComposer,
    $$SubmissionsTableCreateCompanionBuilder,
    $$SubmissionsTableUpdateCompanionBuilder,
    (Submission, $$SubmissionsTableReferences),
    Submission,
    PrefetchHooks Function({bool levelID, bool gdAccountID})> {
  $$SubmissionsTableTableManager(_$ShowcaseDatabase db, $SubmissionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubmissionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubmissionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubmissionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> levelID = const Value.absent(),
            Value<int> levelVersion = const Value.absent(),
            Value<SubmissionStatus> status = const Value.absent(),
            Value<Uint8List> replayHash = const Value.absent(),
            Value<Uint8List?> replayData = const Value.absent(),
            Value<String> modVersion = const Value.absent(),
            Value<String> gdVersion = const Value.absent(),
            Value<int> gdAccountID = const Value.absent(),
            Value<String> rejectionReason = const Value.absent(),
            Value<DateTime?> reviewedAt = const Value.absent(),
            Value<DateTime> submittedAt = const Value.absent(),
          }) =>
              SubmissionsCompanion(
            id: id,
            levelID: levelID,
            levelVersion: levelVersion,
            status: status,
            replayHash: replayHash,
            replayData: replayData,
            modVersion: modVersion,
            gdVersion: gdVersion,
            gdAccountID: gdAccountID,
            rejectionReason: rejectionReason,
            reviewedAt: reviewedAt,
            submittedAt: submittedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int levelID,
            required int levelVersion,
            required SubmissionStatus status,
            required Uint8List replayHash,
            Value<Uint8List?> replayData = const Value.absent(),
            required String modVersion,
            required String gdVersion,
            required int gdAccountID,
            required String rejectionReason,
            Value<DateTime?> reviewedAt = const Value.absent(),
            required DateTime submittedAt,
          }) =>
              SubmissionsCompanion.insert(
            id: id,
            levelID: levelID,
            levelVersion: levelVersion,
            status: status,
            replayHash: replayHash,
            replayData: replayData,
            modVersion: modVersion,
            gdVersion: gdVersion,
            gdAccountID: gdAccountID,
            rejectionReason: rejectionReason,
            reviewedAt: reviewedAt,
            submittedAt: submittedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SubmissionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({levelID = false, gdAccountID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (levelID) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.levelID,
                    referencedTable:
                        $$SubmissionsTableReferences._levelIDTable(db),
                    referencedColumn:
                        $$SubmissionsTableReferences._levelIDTable(db).levelID,
                  ) as T;
                }
                if (gdAccountID) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.gdAccountID,
                    referencedTable:
                        $$SubmissionsTableReferences._gdAccountIDTable(db),
                    referencedColumn: $$SubmissionsTableReferences
                        ._gdAccountIDTable(db)
                        .accountID,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SubmissionsTableProcessedTableManager = ProcessedTableManager<
    _$ShowcaseDatabase,
    $SubmissionsTable,
    Submission,
    $$SubmissionsTableFilterComposer,
    $$SubmissionsTableOrderingComposer,
    $$SubmissionsTableAnnotationComposer,
    $$SubmissionsTableCreateCompanionBuilder,
    $$SubmissionsTableUpdateCompanionBuilder,
    (Submission, $$SubmissionsTableReferences),
    Submission,
    PrefetchHooks Function({bool levelID, bool gdAccountID})>;
typedef $$AccessesTableCreateCompanionBuilder = AccessesCompanion Function({
  Value<int> accessID,
  Value<int?> gdAccountID,
  required int levelID,
  required DateTime accessTime,
});
typedef $$AccessesTableUpdateCompanionBuilder = AccessesCompanion Function({
  Value<int> accessID,
  Value<int?> gdAccountID,
  Value<int> levelID,
  Value<DateTime> accessTime,
});

final class $$AccessesTableReferences
    extends BaseReferences<_$ShowcaseDatabase, $AccessesTable, AccessesData> {
  $$AccessesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _gdAccountIDTable(_$ShowcaseDatabase db) =>
      db.users.createAlias(
          $_aliasNameGenerator(db.accesses.gdAccountID, db.users.accountID));

  $$UsersTableProcessedTableManager? get gdAccountID {
    final $_column = $_itemColumn<int>('gd_account_i_d');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.accountID.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gdAccountIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $LevelsTable _levelIDTable(_$ShowcaseDatabase db) =>
      db.levels.createAlias(
          $_aliasNameGenerator(db.accesses.levelID, db.levels.levelID));

  $$LevelsTableProcessedTableManager get levelID {
    final $_column = $_itemColumn<int>('level_i_d')!;

    final manager = $$LevelsTableTableManager($_db, $_db.levels)
        .filter((f) => f.levelID.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_levelIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AccessesTableFilterComposer
    extends Composer<_$ShowcaseDatabase, $AccessesTable> {
  $$AccessesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get accessID => $composableBuilder(
      column: $table.accessID, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get accessTime => $composableBuilder(
      column: $table.accessTime, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get gdAccountID {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.gdAccountID,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.accountID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LevelsTableFilterComposer get levelID {
    final $$LevelsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.levelID,
        referencedTable: $db.levels,
        getReferencedColumn: (t) => t.levelID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LevelsTableFilterComposer(
              $db: $db,
              $table: $db.levels,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AccessesTableOrderingComposer
    extends Composer<_$ShowcaseDatabase, $AccessesTable> {
  $$AccessesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get accessID => $composableBuilder(
      column: $table.accessID, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get accessTime => $composableBuilder(
      column: $table.accessTime, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get gdAccountID {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.gdAccountID,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.accountID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LevelsTableOrderingComposer get levelID {
    final $$LevelsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.levelID,
        referencedTable: $db.levels,
        getReferencedColumn: (t) => t.levelID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LevelsTableOrderingComposer(
              $db: $db,
              $table: $db.levels,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AccessesTableAnnotationComposer
    extends Composer<_$ShowcaseDatabase, $AccessesTable> {
  $$AccessesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get accessID =>
      $composableBuilder(column: $table.accessID, builder: (column) => column);

  GeneratedColumn<DateTime> get accessTime => $composableBuilder(
      column: $table.accessTime, builder: (column) => column);

  $$UsersTableAnnotationComposer get gdAccountID {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.gdAccountID,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.accountID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LevelsTableAnnotationComposer get levelID {
    final $$LevelsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.levelID,
        referencedTable: $db.levels,
        getReferencedColumn: (t) => t.levelID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LevelsTableAnnotationComposer(
              $db: $db,
              $table: $db.levels,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AccessesTableTableManager extends RootTableManager<
    _$ShowcaseDatabase,
    $AccessesTable,
    AccessesData,
    $$AccessesTableFilterComposer,
    $$AccessesTableOrderingComposer,
    $$AccessesTableAnnotationComposer,
    $$AccessesTableCreateCompanionBuilder,
    $$AccessesTableUpdateCompanionBuilder,
    (AccessesData, $$AccessesTableReferences),
    AccessesData,
    PrefetchHooks Function({bool gdAccountID, bool levelID})> {
  $$AccessesTableTableManager(_$ShowcaseDatabase db, $AccessesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccessesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccessesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccessesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> accessID = const Value.absent(),
            Value<int?> gdAccountID = const Value.absent(),
            Value<int> levelID = const Value.absent(),
            Value<DateTime> accessTime = const Value.absent(),
          }) =>
              AccessesCompanion(
            accessID: accessID,
            gdAccountID: gdAccountID,
            levelID: levelID,
            accessTime: accessTime,
          ),
          createCompanionCallback: ({
            Value<int> accessID = const Value.absent(),
            Value<int?> gdAccountID = const Value.absent(),
            required int levelID,
            required DateTime accessTime,
          }) =>
              AccessesCompanion.insert(
            accessID: accessID,
            gdAccountID: gdAccountID,
            levelID: levelID,
            accessTime: accessTime,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$AccessesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({gdAccountID = false, levelID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (gdAccountID) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.gdAccountID,
                    referencedTable:
                        $$AccessesTableReferences._gdAccountIDTable(db),
                    referencedColumn: $$AccessesTableReferences
                        ._gdAccountIDTable(db)
                        .accountID,
                  ) as T;
                }
                if (levelID) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.levelID,
                    referencedTable:
                        $$AccessesTableReferences._levelIDTable(db),
                    referencedColumn:
                        $$AccessesTableReferences._levelIDTable(db).levelID,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AccessesTableProcessedTableManager = ProcessedTableManager<
    _$ShowcaseDatabase,
    $AccessesTable,
    AccessesData,
    $$AccessesTableFilterComposer,
    $$AccessesTableOrderingComposer,
    $$AccessesTableAnnotationComposer,
    $$AccessesTableCreateCompanionBuilder,
    $$AccessesTableUpdateCompanionBuilder,
    (AccessesData, $$AccessesTableReferences),
    AccessesData,
    PrefetchHooks Function({bool gdAccountID, bool levelID})>;

class $ShowcaseDatabaseManager {
  final _$ShowcaseDatabase _db;
  $ShowcaseDatabaseManager(this._db);
  $$LevelsTableTableManager get levels =>
      $$LevelsTableTableManager(_db, _db.levels);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$SubmissionsTableTableManager get submissions =>
      $$SubmissionsTableTableManager(_db, _db.submissions);
  $$AccessesTableTableManager get accesses =>
      $$AccessesTableTableManager(_db, _db.accesses);
}

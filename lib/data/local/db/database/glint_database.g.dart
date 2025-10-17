// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glint_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $GlintDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $GlintDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $GlintDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<GlintDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorGlintDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $GlintDatabaseBuilderContract databaseBuilder(String name) =>
      _$GlintDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $GlintDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$GlintDatabaseBuilder(null);
}

class _$GlintDatabaseBuilder implements $GlintDatabaseBuilderContract {
  _$GlintDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $GlintDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $GlintDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<GlintDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$GlintDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$GlintDatabase extends GlintDatabase {
  _$GlintDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProfileDao? _profileDaoInstance;

  MembershipDao? _membershipDaoInstance;

  EventLikeDao? _eventLikeDaoInstance;

  SwipeActionDao? _swipeActionDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `profiles` (`userId` TEXT NOT NULL, `username` TEXT NOT NULL, `age` TEXT NOT NULL, `gender` TEXT NOT NULL, `genderPreference` TEXT NOT NULL, `interests` TEXT NOT NULL, `lookingFor` TEXT NOT NULL, `bio` TEXT NOT NULL, `height` TEXT, `occupation` TEXT, `education` TEXT, `workoutHabit` TEXT, `drinkingHabit` TEXT, `smokingHabit` TEXT, `profileViews` TEXT NOT NULL, `profileLikes` TEXT NOT NULL, `pictureUrlList` TEXT NOT NULL, `profileTag` TEXT, `lastLocation` TEXT, `location` TEXT, `dateOfBirthFormatted` TEXT, PRIMARY KEY (`userId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `swipe_actions` (`collabId` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `currentUserId` TEXT NOT NULL, `swipedOnUserId` TEXT NOT NULL, `isUnsent` INTEGER NOT NULL, `action` TEXT NOT NULL, `timestamp` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `memberships` (`userId` TEXT NOT NULL, `superLikes` INTEGER NOT NULL, `aiMessages` INTEGER NOT NULL, `rewinds` INTEGER NOT NULL, `superDm` INTEGER NOT NULL, FOREIGN KEY (`userId`) REFERENCES `profiles` (`userId`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`userId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `user_event_likes` (`userId` TEXT NOT NULL, `eventId` TEXT NOT NULL, FOREIGN KEY (`userId`) REFERENCES `profiles` (`userId`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`userId`, `eventId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProfileDao get profileDao {
    return _profileDaoInstance ??= _$ProfileDao(database, changeListener);
  }

  @override
  MembershipDao get membershipDao {
    return _membershipDaoInstance ??= _$MembershipDao(database, changeListener);
  }

  @override
  EventLikeDao get eventLikeDao {
    return _eventLikeDaoInstance ??= _$EventLikeDao(database, changeListener);
  }

  @override
  SwipeActionDao get swipeActionDao {
    return _swipeActionDaoInstance ??=
        _$SwipeActionDao(database, changeListener);
  }
}

class _$ProfileDao extends ProfileDao {
  _$ProfileDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _profileEntityInsertionAdapter = InsertionAdapter(
            database,
            'profiles',
            (ProfileEntity item) => <String, Object?>{
                  'userId': item.userId,
                  'username': item.username,
                  'age': item.age,
                  'gender': item.gender,
                  'genderPreference': item.genderPreference,
                  'interests': _stringTypeConverter.encode(item.interests),
                  'lookingFor': item.lookingFor,
                  'bio': item.bio,
                  'height': item.height,
                  'occupation': item.occupation,
                  'education': item.education,
                  'workoutHabit': item.workoutHabit,
                  'drinkingHabit': item.drinkingHabit,
                  'smokingHabit': item.smokingHabit,
                  'profileViews': item.profileViews,
                  'profileLikes': item.profileLikes,
                  'pictureUrlList':
                      _stringTypeConverter.encode(item.pictureUrlList),
                  'profileTag': item.profileTag,
                  'lastLocation': item.lastLocation,
                  'location': item.location,
                  'dateOfBirthFormatted': item.dateOfBirthFormatted
                }),
        _profileEntityUpdateAdapter = UpdateAdapter(
            database,
            'profiles',
            ['userId'],
            (ProfileEntity item) => <String, Object?>{
                  'userId': item.userId,
                  'username': item.username,
                  'age': item.age,
                  'gender': item.gender,
                  'genderPreference': item.genderPreference,
                  'interests': _stringTypeConverter.encode(item.interests),
                  'lookingFor': item.lookingFor,
                  'bio': item.bio,
                  'height': item.height,
                  'occupation': item.occupation,
                  'education': item.education,
                  'workoutHabit': item.workoutHabit,
                  'drinkingHabit': item.drinkingHabit,
                  'smokingHabit': item.smokingHabit,
                  'profileViews': item.profileViews,
                  'profileLikes': item.profileLikes,
                  'pictureUrlList':
                      _stringTypeConverter.encode(item.pictureUrlList),
                  'profileTag': item.profileTag,
                  'lastLocation': item.lastLocation,
                  'location': item.location,
                  'dateOfBirthFormatted': item.dateOfBirthFormatted
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProfileEntity> _profileEntityInsertionAdapter;

  final UpdateAdapter<ProfileEntity> _profileEntityUpdateAdapter;

  @override
  Future<ProfileEntity?> getProfileData(String passedId) async {
    return _queryAdapter.query('SELECT * FROM profiles where userId = ?1',
        mapper: (Map<String, Object?> row) => ProfileEntity(
            userId: row['userId'] as String,
            username: row['username'] as String,
            age: row['age'] as String,
            gender: row['gender'] as String,
            genderPreference: row['genderPreference'] as String,
            interests: _stringTypeConverter.decode(row['interests'] as String),
            lookingFor: row['lookingFor'] as String,
            bio: row['bio'] as String,
            height: row['height'] as String?,
            occupation: row['occupation'] as String?,
            education: row['education'] as String?,
            workoutHabit: row['workoutHabit'] as String?,
            drinkingHabit: row['drinkingHabit'] as String?,
            smokingHabit: row['smokingHabit'] as String?,
            profileViews: row['profileViews'] as String,
            profileLikes: row['profileLikes'] as String,
            pictureUrlList:
                _stringTypeConverter.decode(row['pictureUrlList'] as String),
            profileTag: row['profileTag'] as String?,
            lastLocation: row['lastLocation'] as String?,
            location: row['location'] as String?,
            dateOfBirthFormatted: row['dateOfBirthFormatted'] as String?),
        arguments: [passedId]);
  }

  @override
  Future<List<ProfileEntity>> getAllProfiles(String currentUserId) async {
    return _queryAdapter.queryList('SELECT * FROM profiles WHERE userId != ?1',
        mapper: (Map<String, Object?> row) => ProfileEntity(
            userId: row['userId'] as String,
            username: row['username'] as String,
            age: row['age'] as String,
            gender: row['gender'] as String,
            genderPreference: row['genderPreference'] as String,
            interests: _stringTypeConverter.decode(row['interests'] as String),
            lookingFor: row['lookingFor'] as String,
            bio: row['bio'] as String,
            height: row['height'] as String?,
            occupation: row['occupation'] as String?,
            education: row['education'] as String?,
            workoutHabit: row['workoutHabit'] as String?,
            drinkingHabit: row['drinkingHabit'] as String?,
            smokingHabit: row['smokingHabit'] as String?,
            profileViews: row['profileViews'] as String,
            profileLikes: row['profileLikes'] as String,
            pictureUrlList:
                _stringTypeConverter.decode(row['pictureUrlList'] as String),
            profileTag: row['profileTag'] as String?,
            lastLocation: row['lastLocation'] as String?,
            location: row['location'] as String?,
            dateOfBirthFormatted: row['dateOfBirthFormatted'] as String?),
        arguments: [currentUserId]);
  }

  @override
  Future<void> deleteAlreadySwipedOnProfile(int passedId) async {
    await _queryAdapter.queryNoReturn('DELETE FROM profiles WHERE userId is ?1',
        arguments: [passedId]);
  }

  @override
  Future<void> deleteOnBoardingProfile(String passedId) async {
    await _queryAdapter.queryNoReturn('DELETE FROM profiles WHERE userId is ?1',
        arguments: [passedId]);
  }

  @override
  Future<void> clearProfileTable() async {
    await _queryAdapter.queryNoReturn('DELETE FROM profiles');
  }

  @override
  Future<void> insertProfile(ProfileEntity profile) async {
    await _profileEntityInsertionAdapter.insert(
        profile, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertFetchedProfiles(List<ProfileEntity> profiles) async {
    await _profileEntityInsertionAdapter.insertList(
        profiles, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateProfileData(ProfileEntity updatedProfile) async {
    await _profileEntityUpdateAdapter.update(
        updatedProfile, OnConflictStrategy.replace);
  }
}

class _$MembershipDao extends MembershipDao {
  _$MembershipDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _profileMembershipEntityInsertionAdapter = InsertionAdapter(
            database,
            'memberships',
            (ProfileMembershipEntity item) => <String, Object?>{
                  'userId': item.userId,
                  'superLikes': item.superLikes,
                  'aiMessages': item.aiMessages,
                  'rewinds': item.rewinds,
                  'superDm': item.superDm
                }),
        _profileMembershipEntityUpdateAdapter = UpdateAdapter(
            database,
            'memberships',
            ['userId'],
            (ProfileMembershipEntity item) => <String, Object?>{
                  'userId': item.userId,
                  'superLikes': item.superLikes,
                  'aiMessages': item.aiMessages,
                  'rewinds': item.rewinds,
                  'superDm': item.superDm
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProfileMembershipEntity>
      _profileMembershipEntityInsertionAdapter;

  final UpdateAdapter<ProfileMembershipEntity>
      _profileMembershipEntityUpdateAdapter;

  @override
  Future<ProfileMembershipEntity?> getMembership(String userId) async {
    return _queryAdapter.query('SELECT * FROM memberships WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => ProfileMembershipEntity(
            userId: row['userId'] as String,
            superLikes: row['superLikes'] as int,
            aiMessages: row['aiMessages'] as int,
            rewinds: row['rewinds'] as int,
            superDm: row['superDm'] as int),
        arguments: [userId]);
  }

  @override
  Future<void> insertMembership(ProfileMembershipEntity membership) async {
    await _profileMembershipEntityInsertionAdapter.insert(
        membership, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateTheMembershipDetails(
      ProfileMembershipEntity updatedEntity) async {
    await _profileMembershipEntityUpdateAdapter.update(
        updatedEntity, OnConflictStrategy.replace);
  }
}

class _$EventLikeDao extends EventLikeDao {
  _$EventLikeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userEventLikeEntityInsertionAdapter = InsertionAdapter(
            database,
            'user_event_likes',
            (UserEventLikeEntity item) => <String, Object?>{
                  'userId': item.userId,
                  'eventId': item.eventId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserEventLikeEntity>
      _userEventLikeEntityInsertionAdapter;

  @override
  Future<List<UserEventLikeEntity>> getLikedEvents(String userId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM user_event_likes WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => UserEventLikeEntity(
            userId: row['userId'] as String, eventId: row['eventId'] as String),
        arguments: [userId]);
  }

  @override
  Future<void> likeEvent(UserEventLikeEntity entity) async {
    await _userEventLikeEntityInsertionAdapter.insert(
        entity, OnConflictStrategy.replace);
  }
}

class _$SwipeActionDao extends SwipeActionDao {
  _$SwipeActionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _swipeActionEntityInsertionAdapter = InsertionAdapter(
            database,
            'swipe_actions',
            (SwipeActionEntity item) => <String, Object?>{
                  'collabId': item.collabId,
                  'currentUserId': item.currentUserId,
                  'swipedOnUserId': item.swipedOnUserId,
                  'isUnsent': item.isUnsent ? 1 : 0,
                  'action': _swipeActionTypeConverter.encode(item.action),
                  'timestamp': _dateTimeConverter.encode(item.timestamp)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SwipeActionEntity> _swipeActionEntityInsertionAdapter;

  @override
  Future<List<SwipeActionEntity>> getAllSwipes() async {
    return _queryAdapter.queryList(
        'SELECT * FROM swipe_actions ORDER BY timestamp ASC',
        mapper: (Map<String, Object?> row) => SwipeActionEntity(
            collabId: row['collabId'] as int,
            currentUserId: row['currentUserId'] as String,
            swipedOnUserId: row['swipedOnUserId'] as String,
            isUnsent: (row['isUnsent'] as int) != 0,
            action: _swipeActionTypeConverter.decode(row['action'] as String),
            timestamp: _dateTimeConverter.decode(row['timestamp'] as int)));
  }

  @override
  Stream<List<SwipeActionEntity>> watchAllSwipes() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM swipe_actions ORDER BY timestamp ASC',
        mapper: (Map<String, Object?> row) => SwipeActionEntity(
            collabId: row['collabId'] as int,
            currentUserId: row['currentUserId'] as String,
            swipedOnUserId: row['swipedOnUserId'] as String,
            isUnsent: (row['isUnsent'] as int) != 0,
            action: _swipeActionTypeConverter.decode(row['action'] as String),
            timestamp: _dateTimeConverter.decode(row['timestamp'] as int)),
        queryableName: 'swipe_actions',
        isView: false);
  }

  @override
  Future<void> deleteSwipesById(List<int> ids) async {
    const offset = 1;
    final _sqliteVariablesForIds =
        Iterable<String>.generate(ids.length, (i) => '?${i + offset}')
            .join(',');
    await _queryAdapter.queryNoReturn(
        'DELETE FROM swipe_actions WHERE collabId IN (' +
            _sqliteVariablesForIds +
            ')',
        arguments: [...ids]);
  }

  @override
  Future<void> clearAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM swipe_actions');
  }

  @override
  Future<void> insertSwipe(SwipeActionEntity swipe) async {
    await _swipeActionEntityInsertionAdapter.insert(
        swipe, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertSwipes(List<SwipeActionEntity> swipes) async {
    await _swipeActionEntityInsertionAdapter.insertList(
        swipes, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _stringTypeConverter = StringTypeConverter();
final _swipeActionTypeConverter = SwipeActionTypeConverter();
final _dateTimeConverter = DateTimeConverter();

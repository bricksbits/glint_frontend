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
            'CREATE TABLE IF NOT EXISTS `ProfileEntity` (`userId` TEXT NOT NULL, `tag` TEXT NOT NULL, `name` TEXT NOT NULL, `age` TEXT NOT NULL, `designation` TEXT NOT NULL, `profileViews` TEXT NOT NULL, `lastLocation` TEXT NOT NULL, `pronouns` TEXT NOT NULL, `location` TEXT NOT NULL, `bio` TEXT NOT NULL, `lookingFor` TEXT NOT NULL, `choiceOfGender` TEXT NOT NULL, `about` TEXT NOT NULL, `interests` TEXT NOT NULL, `profilePics` TEXT NOT NULL, PRIMARY KEY (`userId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `swipe_actions` (`collabId` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `currentUserId` TEXT NOT NULL, `swipedOnUserId` TEXT NOT NULL, `isUnsent` INTEGER NOT NULL, `action` TEXT NOT NULL, `timestamp` INTEGER NOT NULL)');

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
  SwipeActionDao get swipeActionDao {
    return _swipeActionDaoInstance ??=
        _$SwipeActionDao(database, changeListener);
  }
}

class _$ProfileDao extends ProfileDao {
  _$ProfileDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _profileEntityInsertionAdapter = InsertionAdapter(
            database,
            'ProfileEntity',
            (ProfileEntity item) => <String, Object?>{
                  'userId': item.userId,
                  'tag': item.tag,
                  'name': item.name,
                  'age': item.age,
                  'designation': item.designation,
                  'profileViews': item.profileViews,
                  'lastLocation': item.lastLocation,
                  'pronouns': item.pronouns,
                  'location': item.location,
                  'bio': item.bio,
                  'lookingFor': item.lookingFor,
                  'choiceOfGender': item.choiceOfGender,
                  'about': _stringTypeConverter.encode(item.about),
                  'interests': _stringTypeConverter.encode(item.interests),
                  'profilePics': _stringTypeConverter.encode(item.profilePics)
                },
            changeListener),
        _profileEntityUpdateAdapter = UpdateAdapter(
            database,
            'ProfileEntity',
            ['userId'],
            (ProfileEntity item) => <String, Object?>{
                  'userId': item.userId,
                  'tag': item.tag,
                  'name': item.name,
                  'age': item.age,
                  'designation': item.designation,
                  'profileViews': item.profileViews,
                  'lastLocation': item.lastLocation,
                  'pronouns': item.pronouns,
                  'location': item.location,
                  'bio': item.bio,
                  'lookingFor': item.lookingFor,
                  'choiceOfGender': item.choiceOfGender,
                  'about': _stringTypeConverter.encode(item.about),
                  'interests': _stringTypeConverter.encode(item.interests),
                  'profilePics': _stringTypeConverter.encode(item.profilePics)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProfileEntity> _profileEntityInsertionAdapter;

  final UpdateAdapter<ProfileEntity> _profileEntityUpdateAdapter;

  @override
  Future<ProfileEntity?> getProfileData(String passedId) async {
    return _queryAdapter.query('SELECT * FROM ProfileEntity where userId = ?1',
        mapper: (Map<String, Object?> row) => ProfileEntity(
            userId: row['userId'] as String,
            tag: row['tag'] as String,
            name: row['name'] as String,
            age: row['age'] as String,
            designation: row['designation'] as String,
            profileViews: row['profileViews'] as String,
            lastLocation: row['lastLocation'] as String,
            pronouns: row['pronouns'] as String,
            location: row['location'] as String,
            bio: row['bio'] as String,
            lookingFor: row['lookingFor'] as String,
            about: _stringTypeConverter.decode(row['about'] as String),
            interests: _stringTypeConverter.decode(row['interests'] as String),
            profilePics:
                _stringTypeConverter.decode(row['profilePics'] as String),
            choiceOfGender: row['choiceOfGender'] as String),
        arguments: [passedId]);
  }

  @override
  Stream<List<ProfileEntity>> getAllProfiles() {
    return _queryAdapter.queryListStream('SELECT * FROM ProfileEntity',
        mapper: (Map<String, Object?> row) => ProfileEntity(
            userId: row['userId'] as String,
            tag: row['tag'] as String,
            name: row['name'] as String,
            age: row['age'] as String,
            designation: row['designation'] as String,
            profileViews: row['profileViews'] as String,
            lastLocation: row['lastLocation'] as String,
            pronouns: row['pronouns'] as String,
            location: row['location'] as String,
            bio: row['bio'] as String,
            lookingFor: row['lookingFor'] as String,
            about: _stringTypeConverter.decode(row['about'] as String),
            interests: _stringTypeConverter.decode(row['interests'] as String),
            profilePics:
                _stringTypeConverter.decode(row['profilePics'] as String),
            choiceOfGender: row['choiceOfGender'] as String),
        queryableName: 'ProfileEntity',
        isView: false);
  }

  @override
  Future<void> deleteAlreadySwipedOnProfile(int passedId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM ProfileEntity WHERE userId is (?1)',
        arguments: [passedId]);
  }

  @override
  Future<void> deleteOnBoardingProfile(String passedId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM ProfileEntity WHERE userId is (?1)',
        arguments: [passedId]);
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

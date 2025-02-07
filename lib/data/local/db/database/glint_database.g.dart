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
            'CREATE TABLE IF NOT EXISTS `ProfileEntity` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `designation` TEXT NOT NULL, `age` TEXT NOT NULL, `pronouns` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProfileDao get profileDao {
    return _profileDaoInstance ??= _$ProfileDao(database, changeListener);
  }
}

class _$ProfileDao extends ProfileDao {
  _$ProfileDao(
    this.database,
    this.changeListener,
  ) : _profileEntityInsertionAdapter = InsertionAdapter(
            database,
            'ProfileEntity',
            (ProfileEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'designation': item.designation,
                  'age': item.age,
                  'pronouns': item.pronouns
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final InsertionAdapter<ProfileEntity> _profileEntityInsertionAdapter;

  @override
  Future<void> insertProfileData(ProfileEntity profile) async {
    await _profileEntityInsertionAdapter.insert(
        profile, OnConflictStrategy.abort);
  }
}

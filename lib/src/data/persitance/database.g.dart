// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? join(await sqflite.getDatabasesPath(), name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  WorkOutDao _workoutDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
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
            'CREATE TABLE IF NOT EXISTS `WorkOut` (`id` INTEGER, `steps` INTEGER, `cal` REAL, `duration` INTEGER, `when` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  WorkOutDao get workoutDao {
    return _workoutDaoInstance ??= _$WorkOutDao(database, changeListener);
  }
}

class _$WorkOutDao extends WorkOutDao {
  _$WorkOutDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _workOutInsertionAdapter = InsertionAdapter(
            database,
            'WorkOut',
            (WorkOut item) => <String, dynamic>{
                  'id': item.id,
                  'steps': item.steps,
                  'cal': item.cal,
                  'duration': item.duration,
                  'when': item.when
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _workOutMapper = (Map<String, dynamic> row) => WorkOut(
      row['id'] as int,
      row['steps'] as int,
      row['cal'] as double,
      row['duration'] as int,
      row['when'] as int);

  final InsertionAdapter<WorkOut> _workOutInsertionAdapter;

  @override
  Future<List<WorkOut>> findAllWorkOuts() async {
    return _queryAdapter.queryList('SELECT * FROM WorkOut',
        mapper: _workOutMapper);
  }

  @override
  Stream<WorkOut> findWorkOutById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM WorkOut WHERE id = ?',
        arguments: <dynamic>[id], tableName: 'WorkOut', mapper: _workOutMapper);
  }

  @override
  Future<void> insertWorkOut(WorkOut person) async {
    await _workOutInsertionAdapter.insert(
        person, sqflite.ConflictAlgorithm.abort);
  }
}

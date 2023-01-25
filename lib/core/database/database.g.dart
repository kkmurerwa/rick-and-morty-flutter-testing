// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
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

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

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
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
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
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CharactersDao? _charactersDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `characters` (`id` INTEGER NOT NULL, `id` INTEGER NOT NULL, `name` TEXT NOT NULL, `status` TEXT NOT NULL, `species` TEXT NOT NULL, `type` TEXT NOT NULL, `gender` TEXT NOT NULL, `image` TEXT NOT NULL, `created` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CharactersDao get charactersDao {
    return _charactersDaoInstance ??= _$CharactersDao(database, changeListener);
  }
}

class _$CharactersDao extends CharactersDao {
  _$CharactersDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _characterModelInsertionAdapter = InsertionAdapter(
            database,
            'characters',
            (CharacterModel item) => <String, Object?>{
                  'id': item.id,
                  'id': item.id,
                  'name': item.name,
                  'status': item.status,
                  'species': item.species,
                  'type': item.type,
                  'gender': item.gender,
                  'image': item.image,
                  'created': item.created
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CharacterModel> _characterModelInsertionAdapter;

  @override
  Future<List<CharacterModel>> getAllCharacters() async {
    return _queryAdapter.queryList('SELECT * FROM characters',
        mapper: (Map<String, Object?> row) => CharacterModel(
            id: row['id'] as int,
            name: row['name'] as String,
            status: row['status'] as String,
            species: row['species'] as String,
            type: row['type'] as String,
            gender: row['gender'] as String,
            image: row['image'] as String,
            created: row['created'] as String));
  }

  @override
  Stream<CharacterModel?> findCharacterById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM characters WHERE id = ?1',
        mapper: (Map<String, Object?> row) => CharacterModel(
            id: row['id'] as int,
            name: row['name'] as String,
            status: row['status'] as String,
            species: row['species'] as String,
            type: row['type'] as String,
            gender: row['gender'] as String,
            image: row['image'] as String,
            created: row['created'] as String),
        arguments: [id],
        queryableName: 'characters',
        isView: false);
  }

  @override
  Future<void> insertCharacter(CharacterModel character) async {
    await _characterModelInsertionAdapter.insert(
        character, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertCharacters(List<CharacterModel> characters) async {
    await _characterModelInsertionAdapter.insertList(
        characters, OnConflictStrategy.abort);
  }
}

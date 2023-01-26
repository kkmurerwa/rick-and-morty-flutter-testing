import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ramft/features/characters/data/daos/characters_dao.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../fixtures/test_models.dart';

class MockCharactersDao extends Mock implements CharactersDao {}

void main() {
  late Database database;
  late MockCharactersDao mockCharactersDao;

  setUp(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

    mockCharactersDao = MockCharactersDao();
  });

  tearDown(() async {
    await database.close();
  });

  test('database version should be 0', () async {
    expect(await database.getVersion(), 0);
  });
}
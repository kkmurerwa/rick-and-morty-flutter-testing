import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ramft/features/characters/data/daos/characters_dao.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../../fixtures/test_models.dart';

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

  test('characters dao should allow writing to db', () async {
    when(() => mockCharactersDao.insertCharacters([tCharacter])).thenAnswer((_) async => 3);

    await mockCharactersDao.insertCharacters([tCharacter]);

    verify(() => mockCharactersDao.insertCharacters([tCharacter])).called(1);
  });

  test('characters dao should allow reading from db', () async {
    when(() => mockCharactersDao.insertCharacters([tCharacter])).thenAnswer((_) async => 3);
    when(() => mockCharactersDao.getAllCharacters()).thenAnswer((_) async => [tCharacter]);

    await mockCharactersDao.insertCharacters([tCharacter]);
    final result = await mockCharactersDao.getAllCharacters();

    expect(result, [tCharacter]);
  });


}
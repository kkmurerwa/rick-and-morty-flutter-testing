import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ramft/core/database/database.dart';
import 'package:ramft/core/errors/exceptions.dart';
import 'package:ramft/features/characters/data/daos/characters_dao.dart';
import 'package:ramft/features/characters/data/datasources/characters_local_data_source.dart';

import '../../../../fixtures/test_models.dart';


class MockDatabase extends Mock implements AppDatabase {}
class MockCharactersDao extends Mock implements CharactersDao {}

void main() {
  late MockDatabase mockDatabase;
  late MockCharactersDao mockCharactersDao;
  late CharactersLocalDataSourceImpl dataSource;

  setUp(() {
    mockDatabase = MockDatabase();
    mockCharactersDao = MockCharactersDao();
    dataSource = CharactersLocalDataSourceImpl(database: mockDatabase);
  });

  test('should return list of saved characters form database', () async {
    // arrange
    when(() => mockDatabase.charactersDao).thenReturn(mockCharactersDao);
    final tCharactersDao = mockDatabase.charactersDao;

    when(() => tCharactersDao.getAllCharacters())
        .thenAnswer((_) async => [tCharacterModel]);

    // act
    final result = await dataSource.getCharacters();

    // assert
    expect(result, [tCharacterModel]);
  });

  test('should throw CacheException if database contains no cache', () async {
    // arrange
    when(() => mockDatabase.charactersDao).thenReturn(mockCharactersDao);
    final tCharactersDao = mockDatabase.charactersDao;

    when(() => tCharactersDao.getAllCharacters())
        .thenThrow(Exception());

    // act
    final call = dataSource.getCharacters;

    // assert
    expect(() => call(), throwsA(isA<CacheException>()));
  });

  test('should call dao to save data when fetched from network ', () {
    // arrange
    when(() => mockDatabase.charactersDao).thenReturn(mockCharactersDao);
    final tCharactersDao = mockDatabase.charactersDao;

    when(() => tCharactersDao.insertCharacters([tCharacterModel]))
        .thenAnswer((_) async => 1);

    // act
    dataSource.saveCharacters([tCharacterModel]);

    // assert
    verify(() => tCharactersDao.insertCharacters([tCharacterModel]));
  });

  test('should throw CacheException when database fails to create cache', () async {
    // arrange
    when(() => mockDatabase.charactersDao).thenReturn(mockCharactersDao);
    final tCharactersDao = mockDatabase.charactersDao;

    when(() => tCharactersDao.insertCharacters([tCharacterModel]))
        .thenThrow(Exception());

    // act
    final call = dataSource.saveCharacters;

    // assert
    expect(() => call([tCharacterModel]), throwsA(isA<CacheException>()));
  });
}
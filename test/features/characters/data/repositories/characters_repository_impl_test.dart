import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ramft/core/errors/exceptions.dart';
import 'package:ramft/core/errors/failures.dart';
import 'package:ramft/features/characters/data/datasources/characters_remote_data_source.dart';
import 'package:ramft/features/characters/data/models/character_model.dart';
import 'package:ramft/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:ramft/features/characters/domain/entities/character.dart';

import '../../../../fixtures/test_models.dart';

class MockCharactersDataSource extends Mock implements CharactersRemoteDataSource {}

void main() {
  late MockCharactersDataSource mockDataSource;
  late CharactersRepositoryImpl repository;

  setUpAll(() {
    mockDataSource = MockCharactersDataSource();
    repository = CharactersRepositoryImpl(
      dataSource: mockDataSource,
    );
  });

  test('should query data source for data when getCharacters invoked', () async {
    // arrange
    when(() => mockDataSource.getCharacters(any()))
        .thenAnswer((_) async => [tCharacterModel]);

    // act
    await repository.getCharacters(tPage);

    // assert
    verify(() => mockDataSource.getCharacters(tPage));
  });

  test('should return data when getCharacters invoked successfully', () async {
    // arrange
    when(() => mockDataSource.getCharacters(any()))
        .thenAnswer((_) async => [tCharacterModel]);

    // act
    final result = await repository.getCharacters(tPage);

    // assert
    result.fold((left) => fail('test failed'), (right) {
      expect(right, equals([tCharacterModel]));
    });
  });

  test('should return Failure when getCharacters invoked with exception', () async {
    // arrange
    when(() => mockDataSource.getCharacters(any()))
        .thenThrow(ServerException(""));

    // act
    final result = await repository.getCharacters(tPage);

    // assert
    expect(result, equals(const Left(ServerFailure(""))));
  });

  test('should pass message given by data source on exception', () async {
    // arrange
    when(() => mockDataSource.getCharacters(any()))
        .thenThrow(ServerException(tServerExceptionMessage));

    // act
    final result = await repository.getCharacters(tPage);

    // assert
    expect(result, equals(const Left(ServerFailure(tServerExceptionMessage))));
  });
}
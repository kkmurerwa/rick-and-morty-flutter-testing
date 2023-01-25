import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ramft/core/errors/exceptions.dart';
import 'package:ramft/core/errors/failures.dart';
import 'package:ramft/core/network/network_info.dart';
import 'package:ramft/features/characters/data/datasources/characters_local_data_source.dart';
import 'package:ramft/features/characters/data/datasources/characters_remote_data_source.dart';
import 'package:ramft/features/characters/data/repositories/characters_repository_impl.dart';

import '../../../../fixtures/test_models.dart';

class MockCharactersDataSource extends Mock implements CharactersRemoteDataSource {}
class MockCharactersLocalDataSource extends Mock implements CharactersLocalDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockCharactersDataSource mockRemoteDataSource;
  late MockCharactersLocalDataSource mockLocalDataSource;
  late CharactersRepositoryImpl repository;
  late NetworkInfo networkInfo;

  setUpAll(() {
    mockRemoteDataSource = MockCharactersDataSource();
    mockLocalDataSource = MockCharactersLocalDataSource();
    networkInfo = MockNetworkInfo();
    repository = CharactersRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: networkInfo,
    );
  });

  group('hasInternetConnection', () {
    setUp(() {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);

      when(() => mockLocalDataSource.saveCharacters(any()))
          .thenAnswer((_) async => 1);
    });

    test('should query remote data source for data when getCharacters invoked', () async {
      // arrange
      when(() => mockRemoteDataSource.getCharacters(any()))
          .thenAnswer((_) async => [tCharacterModel]);

      // act
      await repository.getCharacters(tPage);

      // assert
      verify(() => mockRemoteDataSource.getCharacters(tPage));
    });

    test('should return data when getCharacters invoked successfully', () async {
      // arrange
      when(() => mockRemoteDataSource.getCharacters(any()))
          .thenAnswer((_) async => [tCharacterModel]);

      // act
      final result = await repository.getCharacters(tPage);

      // assert
      result.fold((left) => fail('test failed'), (right) {
        expect(right, equals([tCharacterModel]));
      });
    });

    test('should cache data when getCharacters invoked successfully', () async {
      // arrange
      when(() => mockRemoteDataSource.getCharacters(any()))
          .thenAnswer((_) async => [tCharacterModel]);

      // act
      await repository.getCharacters(tPage);

      // assert
      verify(() => mockLocalDataSource.saveCharacters([tCharacterModel]));
    });

    test('should return Failure when getCharacters invoked with exception', () async {
      // arrange
      when(() => mockRemoteDataSource.getCharacters(any()))
          .thenThrow(ServerException(""));

      // act
      final result = await repository.getCharacters(tPage);

      // assert
      expect(result, equals(const Left(ServerFailure(""))));
    });

    test('should pass message given by data source on exception', () async {
      // arrange
      when(() => mockRemoteDataSource.getCharacters(any()))
          .thenThrow(ServerException(tServerExceptionMessage));

      // act
      final result = await repository.getCharacters(tPage);

      // assert
      expect(result, equals(const Left(ServerFailure(tServerExceptionMessage))));
    });
  });

  group('noInternetConnection', () {
    setUp(() {
      when(() => networkInfo.isConnected).thenAnswer((_) async => false);
    });

    test('should query local data source for data when getCharacters invoked with no internet', () async {
      // arrange
      when(() => mockLocalDataSource.getCharacters())
          .thenAnswer((_) async => [tCharacterModel]);

      // act
      await repository.getCharacters(tPage);

      // assert
      verify(() => mockLocalDataSource.getCharacters());
    });

    test('should return cached characters when getCharacters invoked with no internet', () async {
      // arrange
      when(() => mockLocalDataSource.getCharacters())
          .thenAnswer((_) async => [tCharacterModel]);

      // act
      final result = await repository.getCharacters(tPage);

      // assert
      result.fold((left) => fail('test failed'), (right) {
        expect(right, equals([tCharacterModel]));
      });
    });

    test('should return Failure when getCharacters invoked with no internet and exception', () async {
      // arrange
      when(() => mockLocalDataSource.getCharacters())
          .thenThrow(CacheException(""));

      // act
      final result = await repository.getCharacters(tPage);

      // assert
      expect(result, equals(const Left(CacheFailure(""))));
    });

    test('should pass message given by data source on exception if no internet', () async {
      // arrange
      when(() => mockLocalDataSource.getCharacters())
          .thenThrow(CacheException(tCacheExceptionMessage));

      // act
      final result = await repository.getCharacters(tPage);

      // assert
      expect(result, equals(const Left(CacheFailure(tCacheExceptionMessage))));
    });
  });
}
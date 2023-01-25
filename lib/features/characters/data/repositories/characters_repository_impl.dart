import 'package:dartz/dartz.dart';
import 'package:ramft/core/errors/exceptions.dart';
import 'package:ramft/core/errors/failures.dart';
import 'package:ramft/features/characters/data/datasources/characters_local_data_source.dart';
import 'package:ramft/features/characters/data/datasources/characters_remote_data_source.dart';
import 'package:ramft/features/characters/domain/entities/character.dart';
import 'package:ramft/features/characters/domain/repositories/characters_repository.dart';

import '../../../../core/network/network_info.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersRemoteDataSource remoteDataSource;
  final CharactersLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CharactersRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Character>>> getCharacters(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCharacters = await remoteDataSource.getCharacters(page);
        return Right(remoteCharacters);
      } on ServerException catch (exception) {
        return Left(ServerFailure(exception.message));
      }
    } else {
      try {
        final localCharacters = await localDataSource.getCharacters();

        if (localCharacters.isNotEmpty) {
          return Right(localCharacters);
        } else {
          return const Left(CacheFailure('No characters found'));
        }
      } on CacheException catch (exception) {
        return Left(CacheFailure(exception.message));
      }
    }
  }

}
import 'package:dartz/dartz.dart';
import 'package:ramft/core/errors/exceptions.dart';
import 'package:ramft/core/errors/failures.dart';
import 'package:ramft/features/characters/data/datasources/characters_data_source.dart';
import 'package:ramft/features/characters/domain/entities/character.dart';
import 'package:ramft/features/characters/domain/repositories/characters_repository.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersDataSource dataSource;

  CharactersRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Character>>> getCharacters(int page) async {
    try {
      return Right(await dataSource.getCharacters(page));
    } on ServerException catch (exception) {
      return Left(ServerFailure(exception.message));
    }
  }

}
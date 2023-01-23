import 'package:dartz/dartz.dart';
import 'package:ramft/core/errors/failures.dart';
import 'package:ramft/features/characters/domain/entities/character.dart';

abstract class CharactersRepository {
  Future<Either<Failure, List<Character>>> getCharacters(int page);
}
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/character.dart';

abstract class CharactersRepository {
  Future<Either<Failure, List<Character>>> getCharacters(int page);
}
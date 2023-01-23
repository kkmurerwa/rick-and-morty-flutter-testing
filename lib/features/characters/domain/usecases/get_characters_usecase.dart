import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ramft/core/errors/failures.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/character.dart';
import '../repositories/characters_repository.dart';

class GetCharactersUseCase extends UseCase<List<Character>, Params> {
  final CharactersRepository repository;

  GetCharactersUseCase(this.repository);

  @override
  Future<Either<Failure, List<Character>>> call(Params params) async {
    return await repository.getCharacters(params.page);
  }
}

class Params extends Equatable {
  final int page;

  const Params({required this.page});

  @override
  List<Object?> get props => [page];
}
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ramft/core/errors/failures.dart';
import 'package:ramft/features/characters/domain/repositories/characters_repository.dart';
import 'package:ramft/features/characters/domain/usecases/get_characters_usecase.dart';

import '../../../fixtures/test_models.dart';

class MockCharactersRepository extends Mock implements CharactersRepository {}

void main() {
  late GetCharactersUseCase getCharactersUseCase;
  late MockCharactersRepository mockCharactersRepository;

  setUp(() {
    mockCharactersRepository = MockCharactersRepository();
    getCharactersUseCase = GetCharactersUseCase(mockCharactersRepository);
  });

  test('should query repository to get characters on call invoked', () async {
    when(() => mockCharactersRepository.getCharacters(any()))
        .thenAnswer((_) async => const Right([tCharacter]));

    await getCharactersUseCase.call(const Params(page: tPage));

    verify(() => mockCharactersRepository.getCharacters(tPage));
  });

  test('should get characters from the repository if success', () async {
    when(() => mockCharactersRepository.getCharacters(any()))
      .thenAnswer((_) async => const Right([tCharacter]));

    final result = await getCharactersUseCase.call(const Params(page: tPage));

    expect(result, const Right([tCharacter]));
  });

  test('should return failure from repository if failure', () async {
    when(() => mockCharactersRepository.getCharacters(any()))
        .thenAnswer((_) async => const Left(ServerFailure("")));

    final result = await getCharactersUseCase.call(const Params(page: tPage));

    expect(result, const Left(ServerFailure("")));
  });
}
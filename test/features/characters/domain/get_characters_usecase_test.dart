import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ramft/features/characters/domain/entities/character.dart';
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

  test('should get characters from the repository', () async {
    when(() => mockCharactersRepository.getCharacters(any()))
      .thenAnswer((_) async => const Right([tCharacter]));

    final result = await getCharactersUseCase.call(const Params(page: tPage));

    expect(result, const Right([tCharacter]));

    verify(() => mockCharactersRepository.getCharacters(tPage));
  });
}
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ramft/core/errors/failures.dart';
import 'package:ramft/features/characters/domain/usecases/get_characters_usecase.dart';
import 'package:ramft/features/characters/presentation/blocs/characters_bloc.dart';

import '../../../../fixtures/test_models.dart';

class MockGetCharactersUseCase extends Mock implements GetCharactersUseCase {}
class MockParams extends Mock implements Params {}
class MockFakeCharactersEvent extends Mock implements CharactersEvent {}
class MockCharactersBloc extends MockBloc<CharactersEvent, CharactersState> {}

void main() {
  late MockGetCharactersUseCase mockGetCharactersUseCase;
  late CharactersBloc charactersBloc;

  setUp(() {
    mockGetCharactersUseCase = MockGetCharactersUseCase();
    charactersBloc = CharactersBloc(charactersUseCase: mockGetCharactersUseCase);

    registerFallbackValue(MockParams());
  });

  test('should ensure initial state is LoadingState', () {
    expect(charactersBloc.state, equals(LoadingState()));
  });

  test('should call getCharactersUseCase when GetCharactersEvent added', () async {
    // arrange
    when(() => mockGetCharactersUseCase.call(any()))
        .thenAnswer((_) async => const Right([tCharacter]));

    // act
    charactersBloc.add(const GetCharactersEvent(pageNumber: tPage));
    await untilCalled(() => mockGetCharactersUseCase.call(any()));

    // assert
    verify(() => mockGetCharactersUseCase.call(const Params(page: tPage))).called(1);
  });
  
  test('should emit LoadingState then SuccessState when data call is successfull', () async {
    // arrange
    when(() => mockGetCharactersUseCase.call(any()))
        .thenAnswer((_) async => const Right([tCharacter]));

    // assert later
    final expected = [
      LoadingState(),
      const SuccessState(characters: [tCharacter])
    ];
    expectLater(charactersBloc.stream, emitsInOrder(expected));

    // act
    charactersBloc.add(const GetCharactersEvent(pageNumber: tPage));
  });

  test('should emit LoadingState then ErrorState when data call fails', () async {
    // arrange
    when(() => mockGetCharactersUseCase.call(any()))
        .thenAnswer((_) async => const Left(ServerFailure("")));

    // assert later
    final expected = [
      LoadingState(),
      const ErrorState(message: "")
    ];
    expectLater(charactersBloc.stream, emitsInOrder(expected));

    // act
    charactersBloc.add(const GetCharactersEvent(pageNumber: tPage));
  });

  test('should emit ErrorState if unexpected event is triggered', () {
    // assert later
    final expected = [
      const ErrorState(message: 'An unexpected error occurred')
    ];
    expectLater(charactersBloc.stream, emitsInOrder(expected));

    // act
    charactersBloc.add(MockFakeCharactersEvent());
  });

  blocTest<CharactersBloc, CharactersState>('bloc test',
      setUp: () async {
        when(() => mockGetCharactersUseCase.call(const Params(page: 1)))
            .thenAnswer((_) async => const Right([tCharacter]));
      },
      build: () => CharactersBloc(charactersUseCase: mockGetCharactersUseCase),
      act: (bloc) {
        bloc.add(const GetCharactersEvent(pageNumber: 1));
      },
      expect: () => <CharactersState>[
        LoadingState(),
        const SuccessState(characters: [tCharacter]),
      ],
      verify: (_) async {
        verify((() => mockGetCharactersUseCase.call(const Params(page: 1)))).called(1);
      }
  );
}
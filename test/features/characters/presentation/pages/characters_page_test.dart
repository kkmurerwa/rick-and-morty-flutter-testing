import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ramft/features/characters/domain/usecases/get_characters_usecase.dart';
import 'package:ramft/features/characters/presentation/blocs/characters_bloc.dart';
import 'package:ramft/features/characters/presentation/pages/characters_page.dart';
import 'package:ramft/injection_container.dart' as di;

import '../../../../fixtures/test_models.dart';

class MockCharactersBloc extends Mock implements CharactersBloc {}
class MockGetCharactersUseCase extends Mock implements GetCharactersUseCase {}
class MockParams extends Mock implements Params {}

void main() {
  // late MockCharactersBloc mockCharactersBloc;
  // late MockGetCharactersUseCase mockGetCharactersUseCase;
  //
  // setUp(() {
  //   mockCharactersBloc = MockCharactersBloc();
  //   mockGetCharactersUseCase = MockGetCharactersUseCase();
  //
  //   registerFallbackValue(MockParams());
  // });

  // Widget createWidgetUnderTest(Widget widget) {
  //   return MaterialApp(
  //       title: 'Test App',
  //       home: widget
  //   );
  // }
  //
  // group('charactersPage', () {
  //   Future<void> setUpCharactersPage(WidgetTester tester) async {
  //     // await di.init();
  //
  //     await tester.pumpWidget(createWidgetUnderTest(const CharactersPage()));
  //   }
  //
  //   testWidgets("title should be displayed", (WidgetTester tester) async {
  //     when(() => mockCharactersBloc.state).thenReturn(LoadingState());
  //     when(() => mockGetCharactersUseCase.call(any())).thenAnswer((_) async => const Right([tCharacter]));
  //
  //     mockCharactersBloc.add(const GetCharactersEvent(pageNumber: 1));
  //
  //     await setUpCharactersPage(tester);
  //
  //     expect(find.text('Characters'), findsOneWidget);
  //   },);
  // });
}
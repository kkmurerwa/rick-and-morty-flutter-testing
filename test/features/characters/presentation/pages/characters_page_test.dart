import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ramft/features/characters/presentation/pages/characters_page.dart';
import 'package:ramft/injection_container.dart' as di;

void main() {
  Widget createWidgetUnderTest(Widget widget) {
    return MaterialApp(
        title: 'Test App',
        home: widget
    );
  }

  group('charactersPage', () {
    Future<void> setUpCharactersPage(WidgetTester tester) async {
      await di.init();

      await tester.pumpWidget(createWidgetUnderTest(const CharactersPage()));
    }

    testWidgets("title should be displayed", (WidgetTester tester) async {
        await setUpCharactersPage(tester);

        expect(find.text('Characters'), findsOneWidget);
      },
    );
  });
}
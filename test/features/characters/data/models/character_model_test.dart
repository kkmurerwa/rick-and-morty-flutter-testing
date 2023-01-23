import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ramft/features/characters/data/models/character_model.dart';
import 'package:ramft/features/characters/domain/entities/character.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../fixtures/test_models.dart';

void main() {

  test('should be subclass of Character entity',
    () async {
      expect(tCharacterModel, isA<Character>());
    }
  );

  group('fromJson', () {
    test(
      'should return a valid model when a json object is passed',
      () async {
        final result = CharacterModel.fromJson(json.decode(fixture('character.json')));
        expect(result, tCharacterModel);
      }
    );
  });

  // Test toJson
}
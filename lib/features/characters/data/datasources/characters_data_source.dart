import '../models/character_model.dart';

abstract class CharactersDataSource {
  Future<List<CharacterModel>> getCharacters(int page);
}
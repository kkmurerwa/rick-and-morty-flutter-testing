import 'package:floor/floor.dart';
import 'package:ramft/features/characters/data/models/character_model.dart';

@dao
abstract class CharactersDao {
  @Query('SELECT * FROM characters')
  Future<List<CharacterModel>> findAllCharacters();

  @Query('SELECT * FROM characters WHERE id = :id')
  Stream<CharacterModel?> findCharacterById(int id);

  @insert
  Future<void> insertCharacter(CharacterModel character);
}
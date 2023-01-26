import 'package:floor/floor.dart';
import 'package:ramft/features/characters/domain/entities/character.dart';

@dao
abstract class CharactersDao {
  @Query('SELECT * FROM characters')
  Future<List<Character>> getAllCharacters();

  @Query('SELECT * FROM characters WHERE id = :id')
  Stream<Character?> findCharacterById(int id);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertCharacters(List<Character> characters);
}
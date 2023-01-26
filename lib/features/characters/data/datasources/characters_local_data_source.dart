import 'package:ramft/core/database/database.dart';
import 'package:ramft/core/errors/exceptions.dart';
import 'package:ramft/features/characters/domain/entities/character.dart';

abstract class CharactersLocalDataSource {
  /// Gets the cached [List<CharacterModel>] which was previously saved
  ///
  /// Throws [CacheException] if no cached data is present
  Future<List<Character>> getCharacters();

  /// Saves a [List<CharacterModel>] instance for future retrieval
  ///
  /// Throws [CacheException] for all error codes
  Future<void> saveCharacters(List<Character> charactersToCache);
}

class CharactersLocalDataSourceImpl implements CharactersLocalDataSource {
  final AppDatabase database;

  CharactersLocalDataSourceImpl({required this.database});

  @override
  Future<List<Character>> getCharacters() async {
    try {
      final charactersDao = database.charactersDao;
      return await charactersDao.getAllCharacters();
    } catch (e) {
      throw CacheException("");
    }
  }

  @override
  Future<void> saveCharacters(List<Character> charactersToCache) async {
    final charactersDao = database.charactersDao;

    await charactersDao.insertCharacters(charactersToCache);
  }


}
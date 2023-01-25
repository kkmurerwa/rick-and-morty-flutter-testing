import 'package:ramft/core/database/database.dart';
import 'package:ramft/core/errors/exceptions.dart';
import 'package:ramft/features/characters/data/models/character_model.dart';

abstract class CharactersLocalDataSource {
  /// Gets the cached [List<CharacterModel>] which was previously saved
  ///
  /// Throws [CacheException] if no cached data is present
  Future<List<CharacterModel>> getCharacters();

  /// Saves a [List<CharacterModel>] instance for future retrieval
  ///
  /// Throws [CacheException] for all error codes
  Future<void> saveCharacters(List<CharacterModel> charactersToCache);
}

class CharactersLocalDataSourceImpl implements CharactersLocalDataSource {
  final AppDatabase database;

  CharactersLocalDataSourceImpl({required this.database});

  @override
  Future<List<CharacterModel>> getCharacters() async {
    try {
      final charactersDao = database.charactersDao;
      return await charactersDao.getAllCharacters();
    } catch (e) {
      throw CacheException("");
    }
  }

  @override
  Future<void> saveCharacters(List<CharacterModel> charactersToCache) async {
    try {
      final charactersDao = database.charactersDao;

      await charactersDao.insertCharacters(charactersToCache);
    } catch (e) {
      throw CacheException("");
    }
  }


}
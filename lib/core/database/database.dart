import 'dart:async';
import 'package:floor/floor.dart';
import 'package:ramft/features/characters/data/daos/characters_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../features/characters/data/models/character_model.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [CharacterModel])
abstract class AppDatabase extends FloorDatabase {
  CharactersDao get charactersDao;
}
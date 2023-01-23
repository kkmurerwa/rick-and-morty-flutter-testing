import 'package:ramft/features/characters/data/models/character_model.dart';
import 'package:ramft/features/characters/domain/entities/character.dart';

const tPage = 1;

const tServerExceptionMessage = "test message";

const Character tCharacter = Character(
  id: 1,
  name: "Rick Sanchez",
  status: "Alive",
  species: "Human",
  type: "",
  gender: "Male",
  image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
  created: "2017-11-04T18:48:46.250Z",
);

const CharacterModel tCharacterModel = CharacterModel(
  id: 1,
  name: "Rick Sanchez",
  status: "Alive",
  species: "Human",
  type: "",
  gender: "Male",
  image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
  created: "2017-11-04T18:48:46.250Z",
);
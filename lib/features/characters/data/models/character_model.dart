import 'package:ramft/features/characters/domain/entities/character.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'characters')
class CharacterModel extends Character {
  @primaryKey
  final int id;


  const CharacterModel({
    required this.id,
    required String name,
    required String status,
    required String species,
    required String type,
    required String gender,
    required String image,
    required String created
}): super(
    id: id,
    name: name,
    status: status,
    species: species,
    type: type,
    gender: gender,
    image: image,
    created: created
  );

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      image: json['image'],
      created: json['created']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'image': image,
      'created': created
    };
  }
}
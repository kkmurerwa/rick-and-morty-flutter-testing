import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ramft/core/errors/exceptions.dart';

import '../models/character_model.dart';

abstract class CharactersRemoteDataSource {
  Future<List<CharacterModel>> getCharacters(int page);
}

const URL = 'https://rickandmortyapi.com/api/character/?page=';

class CharactersRemoteDataSourceImpl implements CharactersRemoteDataSource {
  final http.Client client;

  CharactersRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CharacterModel>> getCharacters(int page) async {
    final response = await client.get(
      Uri.parse('$URL$page'),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body) as Map<String, dynamic>;
      return (result['results'] as List)
          .map((e) => CharacterModel.fromJson(e))
          .toList();
    } else {
      throw ServerException("");
    }
  }
}
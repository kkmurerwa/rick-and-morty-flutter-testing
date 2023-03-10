import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:ramft/core/errors/exceptions.dart';
import 'package:ramft/features/characters/data/datasources/characters_remote_data_source.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../fixtures/test_models.dart';

class MockHttpClient extends Mock implements http.Client {}
class MockUri extends Mock implements Uri {}

void main() {
  late MockHttpClient mockHttpClient;
  late MockUri mockUri;
  late CharactersRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    registerFallbackValue(MockUri());
    dataSource = CharactersRemoteDataSourceImpl(
      client: mockHttpClient,
    );
  });

  test('should make a GET request with page number in URL', () async {
    // arrange
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response(fixture("response.json"), 200));

    // act
    dataSource.getCharacters(tPage);

    // assert
    verify(() => mockHttpClient.get(
      Uri.parse('$URL$tPage')
    ));
  });

  test('should return a list of characters when status code is 200', () async {
    // arrange
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response(fixture("response.json"), 200));

    // act
    final result = await dataSource.getCharacters(tPage);

    // assert
    expect(result, [tCharacterModel]);
  });

  test('should throw ServerException when status code is not 200', () {
    // arrange
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response("Something went wrong", 404));

    // act
    final call = dataSource.getCharacters;

    // assert
    expect(() => call(tPage), throwsA(isA<ServerException>()));
  });
}
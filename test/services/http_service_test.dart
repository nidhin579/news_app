import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:news_app_nidhin/constants/env/env.dart';
import 'package:news_app_nidhin/services/http_service.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient mockClient;
  late HttpService httpService;

  setUp(() {
    mockClient = MockClient();
    httpService = HttpService(httpClient: mockClient);
  });

  group('HttpService Tests', () {
    test('should return data if the http call completes successfully', () async {
      // Arrange
      const endpoint = '/v2/top-headlines';
      final params = {'category': 'general', 'country': 'us'};
      final uri = Uri.https(Env.baseUrl, endpoint, params);

      final responseJson = {
        'status': 'ok',
        'totalResults': 1,
        'articles': [
          {
            'title': 'Test Article',
            'description': 'Test Description',
            'url': 'https://example.com',
            'urlToImage': 'https://example.com/image.jpg',
            'publishedAt': '2023-06-01T00:00:00Z',
            'content': 'Test Content',
          },
        ],
      };

      when(() => mockClient.get(
        uri,
        headers: {'X-Api-Key': Env.apiKey},
      )).thenAnswer((_) async => http.Response(jsonEncode(responseJson), 200));

      // Act
      final result = await httpService.get(endpoint: endpoint, params: params);

      // Assert
      expect(result, responseJson);
      verify(() => mockClient.get(uri, headers: {'X-Api-Key': Env.apiKey})).called(1);
    });

    test('should throw an exception if the http call completes with an error', () async {
      // Arrange
      const endpoint = '/v2/top-headlines';
      final params = {'category': 'general', 'country': 'us'};
      final uri = Uri.https(Env.baseUrl, endpoint, params);

      when(() => mockClient.get(
        uri,
        headers: {'X-Api-Key': Env.apiKey},
      )).thenAnswer((_) async => http.Response('Not Found', 404));

      // Act
      final call = httpService.get(endpoint: endpoint, params: params);

      // Assert
      expect(call, throwsException);
      verify(() => mockClient.get(uri, headers: {'X-Api-Key': Env.apiKey})).called(1);
    });
  });
}
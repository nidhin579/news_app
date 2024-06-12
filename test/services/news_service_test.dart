import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app_nidhin/app/app.locator.dart';
import 'package:news_app_nidhin/enums/news_category.dart';
import 'package:news_app_nidhin/services/http_service.dart';
import 'package:news_app_nidhin/services/news_service.dart';

class MockHttpService extends Mock implements HttpService {}

void main() {
  late MockHttpService mockHttpService;
  late NewsService newsService;

  setUp(() {
    // Register the mock service with the locator
    mockHttpService = MockHttpService();
    locator.registerSingleton<HttpService>(mockHttpService);
    newsService = NewsService();
  });

  tearDown(() {
    // Clear the locator
    locator.reset();
  });

  group('NewsService Tests', () {
    test('should switch category and reset pagination', () {
      // Arrange
      const newCategory = NewsCategory.sports;

      // Act
      newsService.switchCategory(newCategory);

      // Assert
      expect(newsService.currentCategory, newCategory);
      expect(newsService.currentPage, 1);
      expect(newsService.loadedAllArticles, false);
    });

    test('should fetch news articles and update pagination', () async {
      // Arrange
      final mockResponse = {
        'status': '200',
        'totalResults': 6,
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

      when(() => mockHttpService.get(
            endpoint: any(named: 'endpoint'),
            params: any(named: 'params'),
          )).thenAnswer((_) async => mockResponse);

      // Act
      final articles = await newsService.fetchNews();

      // Assert
      expect(articles.length, 1);
      expect(articles[0].title, 'Test Article');
      expect(newsService.currentPage, 2);
      expect(newsService.loadedAllArticles, false);
    });

    test('should set loadedAllArticles to true when no more articles',
        () async {
      // Arrange
      final mockResponse = {
        'totalResults': 0,
        'articles': [],
        'status': '200',
      };

      when(() => mockHttpService.get(
            endpoint: any(named: 'endpoint'),
            params: any(named: 'params'),
          )).thenAnswer((_) async => mockResponse);

      // Act
      final articles = await newsService.fetchNews();

      // Assert
      expect(articles.length, 0);
      expect(newsService.loadedAllArticles, true);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app_nidhin/app/app.locator.dart';
import 'package:news_app_nidhin/app/app.router.dart';
import 'package:news_app_nidhin/enums/news_category.dart';
import 'package:news_app_nidhin/models/article.dart';
import 'package:news_app_nidhin/services/news_service.dart';
import 'package:news_app_nidhin/ui/views/home/home_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class MockNewsService extends Mock implements NewsService {}

class MockSnackbarService extends Mock implements SnackbarService {}

class MockNavigationService extends Mock implements NavigationService {}

void main() {
  late MockNewsService mockNewsService;
  late MockSnackbarService mockSnackbarService;
  late MockNavigationService mockNavigationService;
  late HomeViewModel homeViewModel;

  setUp(() {
    mockNewsService = MockNewsService();
    mockSnackbarService = MockSnackbarService();
    mockNavigationService = MockNavigationService();
    locator.registerSingleton<NewsService>(mockNewsService);
    locator.registerSingleton<SnackbarService>(mockSnackbarService);
    locator.registerSingleton<NavigationService>(mockNavigationService);

    homeViewModel = HomeViewModel();
  });

  tearDown(() {
    locator.reset();
  });

  group('HomeViewModel Tests', () {
    test('should switch category and refresh news', () async {
      const newCategory = NewsCategory.sports;
      when(() => mockNewsService.currentCategory).thenReturn(NewsCategory.general);
      when(() => mockNewsService.switchCategory(newCategory)).thenAnswer((_) async => {});
      when(() => mockNewsService.fetchNews()).thenAnswer((_) async => []);

      homeViewModel.switchCategory(newCategory);

      verify(() => mockNewsService.switchCategory(newCategory)).called(1);
      verify(() => mockNewsService.fetchNews()).called(1);
    });

    test('should fetch news and add articles', () async {
      final articles = [
        Article(
          title: 'Test Article',
          description: 'Test Description',
          url: 'https://example.com',
          urlToImage: 'https://example.com/image.jpg',
          publishedAt: DateTime.parse('2023-06-01T00:00:00Z'),
          content: 'Test Content',
        ),
      ];
      when(() => mockNewsService.fetchNews()).thenAnswer((_) async => articles);

      await homeViewModel.fetchNews();

      expect(homeViewModel.articles, articles);
      verify(() => mockNewsService.fetchNews()).called(1);
    });

    test('should show snackbar on fetch news failure', () async {
      when(() => mockNewsService.fetchNews()).thenThrow(Exception('Failed to fetch news'));

      await homeViewModel.fetchNews();

      verify(() => mockNewsService.fetchNews()).called(1);
      verify(() => mockSnackbarService.showSnackbar(message: 'Failed to fetch news! Please try again.')).called(1);
    });

    test('should navigate to news detail view', () {
      final article = Article(
        title: 'Test Article',
        description: 'Test Description',
        url: 'https://example.com',
        urlToImage: 'https://example.com/image.jpg',
        publishedAt: DateTime.parse('2023-06-01T00:00:00Z'),
        content: 'Test Content',
      );

      homeViewModel.navigateToNewsDescription(article);

      verify(() => mockNavigationService.navigateToNewsDetailView(article: article)).called(1);
    });
  });
}
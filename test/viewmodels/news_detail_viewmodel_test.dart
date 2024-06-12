import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app_nidhin/app/app.locator.dart';
import 'package:news_app_nidhin/models/article.dart';
import 'package:news_app_nidhin/services/url_launcher_service.dart';
import 'package:news_app_nidhin/ui/views/news_detail/news_detail_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class MockUrlLauncherService extends Mock implements UrlLauncherService {}

class MockSnackbarService extends Mock implements SnackbarService {}

void main() {
  late MockUrlLauncherService mockUrlLauncherService;
  late MockSnackbarService mockSnackbarService;
  late NewsDetailViewModel newsDetailViewModel;

  setUp(() {
    mockUrlLauncherService = MockUrlLauncherService();
    mockSnackbarService = MockSnackbarService();
    locator.registerSingleton<UrlLauncherService>(mockUrlLauncherService);
    locator.registerSingleton<SnackbarService>(mockSnackbarService);

    final article = Article(
      title: 'Test Article',
      description: 'Test Description',
      url: 'https://example.com',
      urlToImage: 'https://example.com/image.jpg',
      publishedAt: DateTime.parse('2023-06-01T00:00:00Z'),
      content: 'Test Content',
    );

    newsDetailViewModel = NewsDetailViewModel(article: article);
  });

  tearDown(() {
    locator.reset();
  });

  group('NewsDetailViewModel Tests', () {
    test('should launch article URL successfully', () async {
      final Uri testUrl = Uri.parse('https://example.com');
      when(() => mockUrlLauncherService.launch(testUrl)).thenAnswer((_) async => {});

      newsDetailViewModel.launchArticle();

      verify(() => mockUrlLauncherService.launch(testUrl)).called(1);
    });

    test('should show snackbar on launch article URL failure', () async {
      final Uri testUrl = Uri.parse('https://example.com');
      when(() => mockUrlLauncherService.launch(testUrl)).thenThrow(Exception('Could not launch URL'));

      newsDetailViewModel.launchArticle();

      verify(() => mockUrlLauncherService.launch(testUrl)).called(1);
      verify(() => mockSnackbarService.showSnackbar(message: 'Exception: Could not launch URL')).called(1);
    });
  });
}
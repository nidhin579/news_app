import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app_nidhin/app/app.locator.dart';
import 'package:news_app_nidhin/enums/news_category.dart';
import 'package:news_app_nidhin/services/news_service.dart';
import 'package:news_app_nidhin/ui/views/home/home_view.dart';
import 'package:news_app_nidhin/ui/views/home/widgets/category_chip.dart';
import 'package:stacked_services/stacked_services.dart';

class MockNewsService extends Mock implements NewsService {}

class MockSnackbarService extends Mock implements SnackbarService {}

class MockNavigationService extends Mock implements NavigationService {}

void main() {
  late MockNewsService mockNewsService;
  late MockSnackbarService mockSnackbarService;
  late MockNavigationService mockNavigationService;

  setUpAll(() {
    mockSnackbarService = MockSnackbarService();
    mockNewsService = MockNewsService();
    mockNavigationService = MockNavigationService();

    locator.registerSingleton<NewsService>(mockNewsService);
    locator.registerSingleton<SnackbarService>(mockSnackbarService);
    locator.registerSingleton<NavigationService>(mockNavigationService);

    const newCategory = NewsCategory.sports;
    when(() => mockNewsService.currentCategory)
        .thenReturn(NewsCategory.general);
    when(() => mockNewsService.switchCategory(newCategory))
        .thenAnswer((_) async => {});
    when(() => mockNewsService.fetchNews()).thenAnswer((_) async => []);
  });

  group('HomeViewBody Tests', () {
    testWidgets('should display headlines and categories',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: Scaffold(body: HomeView())));

      expect(find.text('Headlines'), findsOneWidget);
      expect(
          find.byType(CategoryChip), findsNWidgets(NewsCategory.values.length));
    });

    testWidgets('should display CircularProgressIndicator when busy',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: Scaffold(body: HomeView())));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}

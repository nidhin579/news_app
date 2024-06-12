import 'package:news_app_nidhin/app/app.locator.dart';
import 'package:news_app_nidhin/app/app.router.dart';
import 'package:news_app_nidhin/enums/news_category.dart';
import 'package:news_app_nidhin/models/article.dart';
import 'package:news_app_nidhin/services/news_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends FutureViewModel {
  final NewsService newsService = locator<NewsService>();
  final SnackbarService snackBarService = locator<SnackbarService>();
  final NavigationService navigationService = locator<NavigationService>();

  @override
  Future futureToRun() => fetchNews(isNew: true);

  NewsCategory get currentCategory => newsService.currentCategory;

  List<Article> articles = [];

  bool get isArticlesEmpty => articles.isEmpty;

  void switchCategory(NewsCategory category) {
    if (currentCategory != category) {
      newsService.switchCategory(category);
      articles.clear();
      notifyListeners();

      initialise();
    }
  }

  void addArticles(List<Article> articles) {
    this.articles.addAll(articles);
    notifyListeners();
  }

  Future<void> fetchNews({bool isNew = false}) async {
    try {
      final List<Article> articles = await newsService.fetchNews(isNew: isNew);
      if (isNew) this.articles.clear();

      addArticles(articles);
    } catch (e) {
      snackBarService.showSnackbar(
          message: 'Failed to fetch news! Please try again.');
    }
  }

  Future<void> fetchMoreNews() async {
    setBusy(true);
    await fetchNews();
    setBusy(false);
  }

  void navigateToNewsDescription(Article article) {
    navigationService.navigateToNewsDetailView(article: article);
  }
}

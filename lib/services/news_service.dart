import 'package:news_app_nidhin/app/app.locator.dart';
import 'package:news_app_nidhin/enums/news_category.dart';
import 'package:news_app_nidhin/models/article.dart';
import 'package:news_app_nidhin/models/headlines_response.dart';
import 'package:news_app_nidhin/services/http_service.dart';

class NewsService {
  final HttpService httpService = locator<HttpService>();

  static const String _countryCode = 'pt';

  static const int _pageSize = 10;
  int currentPage = 0;
  bool loadedAllArticles = false;

  NewsCategory currentCategory = NewsCategory.general;

  void switchCategory(NewsCategory category) {
    currentCategory = category;
    // Current page defaults to zero when category changes
    currentPage = 0;
    loadedAllArticles = false;
  }

  Future<List<Article>> fetchNews() async {
    final responseJson = await httpService.get(
      endpoint: '/v2/top-headlines',
      params: {
        'category': currentCategory.name,
        'page': '$currentPage',
        'pageSize': '$_pageSize',
        'country': _countryCode,
      },
    );

    final HeadlinesResponse response = HeadlinesResponse.fromJson(responseJson);
    if (response.totalResults == _pageSize) {
      currentPage++;
    } else {
      loadedAllArticles = true;
    }

    return response.articles;
  }
}

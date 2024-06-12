import 'package:news_app_nidhin/app/app.locator.dart';
import 'package:news_app_nidhin/models/article.dart';
import 'package:news_app_nidhin/services/url_launcher_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NewsDetailViewModel extends BaseViewModel {
  final UrlLauncherService urlLauncherService = locator<UrlLauncherService>();
  final SnackbarService snackBarService = locator<SnackbarService>();

  final Article article;

  NewsDetailViewModel({required this.article});

  void launchArticle() {
    try {
      final Uri url = Uri.parse(article.url ?? '');
      urlLauncherService.launch(url);
    } catch (e) {
      snackBarService.showSnackbar(message: e.toString());
    }
  }
}

import 'package:news_app_nidhin/models/article.dart';

class HeadlinesResponse {
  String status;
  int totalResults;
  List<Article> articles;

  HeadlinesResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory HeadlinesResponse.fromJson(Map<String, dynamic> json) {
    return HeadlinesResponse(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: List<Article>.from(
          json['articles'].map((article) => Article.fromJson(article))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'articles': articles.map((article) => article.toJson()).toList(),
    };
  }
}

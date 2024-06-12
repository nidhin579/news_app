import 'package:flutter/material.dart';
import 'package:news_app_nidhin/models/article.dart';
import 'package:stacked/stacked.dart';

import 'news_detail_viewmodel.dart';

class NewsDetailView extends StackedView<NewsDetailViewModel> {
  const NewsDetailView({
    Key? key,
    required this.article,
  }) : super(key: key);
  final Article article;

  @override
  Widget builder(
    BuildContext context,
    NewsDetailViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  NewsDetailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      NewsDetailViewModel(article: article);
}

import 'package:flutter/material.dart';
import 'package:news_app_nidhin/constants/env/colors.dart';
import 'package:news_app_nidhin/models/article.dart';
import 'package:stacked/stacked.dart';
import 'package:news_app_nidhin/ui/views/news_detail/news_detail_viewmodel.dart';
import 'package:news_app_nidhin/ui/views/news_detail/news_details_view_body.dart';

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
    return const Scaffold(
      backgroundColor: AppColors.white,
      body: NewsDetailsViewBody(),
    );
  }

  @override
  NewsDetailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      NewsDetailViewModel(article: article);
}

import 'package:flutter/material.dart';
import 'package:news_app_nidhin/constants/env/colors.dart';
import 'package:news_app_nidhin/models/article.dart';
import 'package:news_app_nidhin/ui/common/date_time_helper.dart';
import 'package:news_app_nidhin/ui/common/ui_helpers.dart';
import 'package:news_app_nidhin/ui/views/news_detail/news_detail_viewmodel.dart';
import 'package:news_app_nidhin/ui/widgets/app_network_image.dart';
import 'package:stacked/stacked.dart';

class NewsDetailsViewBody extends ViewModelWidget<NewsDetailViewModel> {
  const NewsDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context, NewsDetailViewModel viewModel) {
    Article article = viewModel.article;
    return Stack(
      children: [
        AppNetworkImage(
          url: article.urlToImage,
          height: screenHeight(context) * 0.4 + 20,
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight(context) * 0.4),
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title ?? '',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      article.description ?? '',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    InkWell(
                      onTap: () => viewModel.launchArticle(),
                      child: const Text(
                        'Read more',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      '${article.author ?? ''} - ${article.source?.name ?? ''}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      DateTimeHelper.formatDate(
                        article.publishedAt.toString(),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SafeArea(
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: const BackButton(),
          ),
        )
      ],
    );
  }
}

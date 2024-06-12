import 'package:flutter/material.dart';
import 'package:news_app_nidhin/constants/env/colors.dart';
import 'package:news_app_nidhin/enums/news_category.dart';
import 'package:news_app_nidhin/ui/views/home/widgets/category_chip.dart';
import 'package:news_app_nidhin/ui/views/home/widgets/news_card.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.cornflowerRed,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Headlines',
                style: TextStyle(
                  fontSize: 32,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                  color: AppColors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 8),
                      child: Wrap(
                        children: List.generate(
                          NewsCategory.values.length,
                          (index) {
                            NewsCategory category = NewsCategory.values[index];
                            return CategoryChip(
                              category: category.name,
                              isSelected: viewModel.currentCategory == category,
                              onTap: () => viewModel.switchCategory(category),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: viewModel.isBusy && viewModel.isArticlesEmpty
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : NotificationListener<ScrollNotification>(
                              onNotification: (notification) {
                                if (notification is ScrollEndNotification &&
                                    notification.metrics.extentAfter == 0 &&
                                    !viewModel.isBusy) {
                                  // User has reached the end of the list
                                  // Load more data or trigger pagination in flutter
                                  viewModel.fetchMoreNews();
                                }
                                return false;
                              },
                              child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(height: 10);
                                  },
                                  itemCount: viewModel.articles.length,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () =>
                                          viewModel.navigateToNewsDescription(
                                              viewModel.articles[index]),
                                      child: NewsCard(
                                          article: viewModel.articles[index]),
                                    );
                                  }),
                            ),
                    ),
                    if (viewModel.isBusy && !viewModel.isArticlesEmpty)
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(
                          color: AppColors.cornflowerRed,
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}

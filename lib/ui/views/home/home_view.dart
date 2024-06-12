import 'package:flutter/material.dart';
import 'package:news_app_nidhin/constants/env/colors.dart';
import 'package:news_app_nidhin/ui/views/home/home_view_body.dart';
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
    return const Scaffold(
      backgroundColor: AppColors.cornflowerRed,
      body: SafeArea(child: HomeViewBody()),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}

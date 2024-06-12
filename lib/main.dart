import 'package:flutter/material.dart';
import 'package:news_app_nidhin/app/app.bottomsheets.dart';
import 'package:news_app_nidhin/app/app.dialogs.dart';
import 'package:news_app_nidhin/app/app.locator.dart';
import 'package:news_app_nidhin/app/app.router.dart';
import 'package:news_app_nidhin/constants/env/colors.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: AppColors.rhino,
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}

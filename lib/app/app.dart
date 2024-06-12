import 'package:news_app_nidhin/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:news_app_nidhin/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:news_app_nidhin/ui/views/home/home_view.dart';
import 'package:news_app_nidhin/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:news_app_nidhin/services/news_service.dart';
import 'package:news_app_nidhin/services/http_service.dart';
import 'package:news_app_nidhin/ui/views/news_detail/news_detail_view.dart';
import 'package:news_app_nidhin/services/url_launcher_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: NewsDetailView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: NewsService),
    LazySingleton(classType: HttpService),
    LazySingleton(classType: SnackbarService),

    LazySingleton(classType: UrlLauncherService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}

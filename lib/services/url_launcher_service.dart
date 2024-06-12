import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  Future<void> launch(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

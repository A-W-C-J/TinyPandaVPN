import 'package:get/get.dart';
import 'package:sail/pages/home/home_page.dart';
import 'package:sail/pages/webview_widget.dart';



part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.HOME;
  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomePage()
    ),
    GetPage(
        name: _Paths.WEBVIEW,
        page: () => const WebViewWidget()
    ),
  ];
}

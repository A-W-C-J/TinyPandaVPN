import 'package:fluro/fluro.dart';
import 'package:sail/router/router_handlers.dart';

class Routers {
  static String home = "/";
  static String webView = "/web-view";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = notFindHandler;

    router.define(home, handler: homeHandler);

    router.define(webView, handler: webViewHandler);
  }
}

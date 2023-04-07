import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:sail/pages/home/home_page.dart';
import 'package:sail/pages/404/not_find_page.dart';


import 'package:sail/pages/webview_widget.dart';
import 'dart:convert';

/// 入口
Handler homeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
      return const HomePage();
    });

/// 404页面
Handler notFindHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
      return const NotFindPage();
    });






/// WebView页
Handler webViewHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
      var title = jsonDecode(parameters["titleName"]!.first);
      var url = jsonDecode(parameters["url"]!.first);
      return WebViewWidget(name: title, url: url);
    });

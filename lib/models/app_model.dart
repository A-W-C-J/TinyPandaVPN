import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sail/adapters/leaf_ffi/config.dart';
import 'package:sail/channels/vpn_manager.dart';
import 'package:sail/constant/app_strings.dart';
import 'package:sail/json2dart/V2rayConfig.dart';
import 'package:sail/models/base_model.dart';

import 'package:sail/utils/common_util.dart';

class AppModel extends BaseModel {
  VpnManager vpnManager = VpnManager();
  bool isOn = false;
  bool isSelect = false;
  bool isFreeEnd=true;
  bool isFree=true;
  PageController pageController = PageController(initialPage: 0);
  String appTitle = 'TinyPandaVPN';
  Config config = Config();
  V2rayConfig v2rayConfig = V2rayConfig();
  String ConfigTmp = '';
  // MethodChannel methodsChannel = MethodChannel("com.captain.bestvpn/status");

  AppModel() {
    rootBundle.loadString('assets/json/v2ray_config.json').then((value) {
      ConfigTmp = value.toString();
    });
    // methodsChannel.setMethodCallHandler(_nativeCallHandler);
  }

  // Future<dynamic> _nativeCallHandler(MethodCall call) async {
  //   if (call.method == 'setStatus') {
  //     bool callMsg = call.arguments;
  //     isOn = callMsg;
  //     notifyListeners();
  //   }
  // }

  final Map _tabMap = {
    0: AppStrings.appName,
  };
  void jumpToPage(int page) {
    pageController.jumpToPage(page);
    appTitle = _tabMap[page];
    notifyListeners();
  }
  Future<bool> getStatus() async {
    isOn = await vpnManager.getStatus();
    notifyListeners();
    return isOn;

  }
  void togglePowerButton() async {
    await vpnManager.toggle();
    notifyListeners();
  }
  void closeV2ray() async {
    isOn = await vpnManager.closeV2ray();
    notifyListeners();
  }
  void clearSubs() async {
    isOn = await vpnManager.clearSubs();
    notifyListeners();
  }
  void toggleSettingButton() async {
    await vpnManager.toggleSetting();
    notifyListeners();
  }
  void toggleLogButton() async {
    await vpnManager.toggleLog();
    notifyListeners();
  }
  void subSettingButton() async {
    isOn = await vpnManager.subSettingButton();
    notifyListeners();
  }
  void toggleV2ray() async {
    await vpnManager.toggleV2ray();
    notifyListeners();
  }
  Future<String> getRemark() async {
    var conf = await vpnManager.getRemark();
    return conf;
  }
  Future<bool> sendSubscribeUrl(String url) async {
   return await vpnManager.sendSubscribeUrl(url);
  }
  Future<bool> sendUpdateSubBroadcast() async {
    return await vpnManager.sendUpdateSubBroadcast();
  }
  Future<bool> sendSelectBroadcast() async {
    return await vpnManager.sendSelectBroadcast();
  }

  Future<bool> iap(String productId) async {
    return await vpnManager.iap(productId);
  }
}

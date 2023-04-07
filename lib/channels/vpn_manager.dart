import 'package:flutter/services.dart';
import 'package:sail/utils/common_util.dart';

class VpnManager {
  Future<bool> getStatus() async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    bool result;
    try {
      result = await platform.invokeMethod("getStatus");
    } on PlatformException catch (e) {
      print(e.toString());
      rethrow;
    }
    return result;
  }
  Future<bool> toggle() async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    bool result = false;
    try {
      result = await platform.invokeMethod("toggle");
    } on PlatformException catch (e) {
      print(e.toString());
      rethrow;
    }
    return result;
  }
  Future<bool> closeV2ray() async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    bool result = false;
    try {
      result = await platform.invokeMethod("closeV2ray");
    } on PlatformException catch (e) {
      print(e.toString());
      rethrow;
    }
    return result;
  }
  Future<bool> clearSubs() async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    bool result = false;
    try {
      result = await platform.invokeMethod("clearSubs");
    } on PlatformException catch (e) {
      print(e.toString());
      rethrow;
    }
    return result;
  }
  Future<bool> toggleSetting() async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    bool result = false;
    try {
      result = await platform.invokeMethod("toggleSetting");
    } on PlatformException catch (e) {
      print(e.toString());
      rethrow;
    }
    return result;
  }
  Future<bool> toggleLog() async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    bool result = false;
    try {
      result = await platform.invokeMethod("toggleLog");
    } on PlatformException catch (e) {
      print(e.toString());
      rethrow;
    }
    return result;
  }
  Future<bool> subSettingButton() async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    bool result = false;
    try {
      result = await platform.invokeMethod("subSettingButton");
    } on PlatformException catch (e) {
      print(e.toString());
      rethrow;
    }
    return result;
  }
  Future<bool> toggleV2ray() async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    bool result = false;
    try {
      result = await platform.invokeMethod("toggleV2ray");
    } on PlatformException catch (e) {
      print(e.toString());
      rethrow;
    }
    return result;
  }
  Future<bool> sendSubscribeUrl(String url) async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    bool result = false;
    try {
      result = await platform.invokeMethod("sendSubscribeUrl",url);
    } on PlatformException catch (e) {
      print(e.toString());
      rethrow;
    }
    return result;
  }
  Future<bool> sendUpdateSubBroadcast() async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    bool result = false;
    try {
      result = await platform.invokeMethod("sendUpdateSubBroadcast");
    } on PlatformException catch (e) {
      print(e.toString());
      rethrow;
    }
    return result;
  }
  Future<bool> sendSelectBroadcast() async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    bool result = false;
    try {
      result = await platform.invokeMethod("sendSelectBroadcast");
    } on PlatformException catch (e) {
      print(e.toString());
      rethrow;
    }
    return result;
  }
  Future<bool> iap(String productId) async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    bool result = false;
    try {
      result = await platform.invokeMethod("iap", {'productId':productId});
    } on PlatformException catch (e) {
      print(e.toString());
      rethrow;
    }
    return result;
  }
  Future<String> getTunnelLog() async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    String result;
    try {
      result = await platform.invokeMethod("getTunnelLog");
    } on PlatformException catch (e) {
      print(e.toString());

      rethrow;
    }
    return result;
  }
  Future<String> getTunnelConfiguration() async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    String result;
    try {
      result = await platform.invokeMethod("getTunnelConfiguration");
    } on PlatformException catch (e) {
      print(e.toString());

      rethrow;
    }
    return result;
  }
  Future<String> getRemark() async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    String result;
    try {
      result = await platform.invokeMethod("getRemark");
    } on PlatformException catch (e) {
      print(e.toString());

      rethrow;
    }
    return result;
  }
  Future<String> setTunnelConfiguration(String conf) async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    String result;
    try {

      result = await platform.invokeMethod("setTunnelConfiguration", conf);
    } on PlatformException catch (e) {
      print(e.toString());

      rethrow;
    }
    return result;
  }
  Future<String> setConfigTemplate(String template) async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    String result;
    try {
      result = await platform.invokeMethod("setConfigTemplate", template);
    } on PlatformException catch (e) {
      print(e.toString());

      rethrow;
    }
    return result;
  }
}


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown.dart';
import 'package:flutter_countdown_timer/countdown_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:sail/constant/app_colors.dart';
import 'package:sail/generated/locales.g.dart';
import 'package:sail/models/app_model.dart';

import 'package:sail/widgets/logo_bar.dart';
import 'package:sail/widgets/power_btn.dart';

import 'package:sail/widgets/select_location.dart';

import 'my_subscribe.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  HomeWidgetState createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget>
    with AutomaticKeepAliveClientMixin {
  bool _isLoadingData = false;
  late AppModel _appModel;






  bool isRunning = false;
  MethodChannel methodsChannel =
      const MethodChannel("com.captain.bestvpn/status");
  late CountdownController countdownController;

  @override
  void initState() {


    methodsChannel.setMethodCallHandler(_nativeCallHandler);
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    _appModel = Provider.of<AppModel>(context);
    if (!_isLoadingData) {
      countdownController = CountdownController(
          duration: const Duration(seconds: 300),
          onEnd: () {
            _isLoadingData=false;
            _appModel.isFreeEnd = true;
            _appModel.notifyListeners();
          });
      _isLoadingData = true;
    }

    // _appModel.isOn=await _appModel.getStatus();


  }

  @override
  Widget build(BuildContext context) {
    if (!countdownController.isRunning) countdownController.start();
    super.build(context);
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Logo bar
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(75),
                  right: ScreenUtil().setWidth(75)),
              child: LogoBar(
                isOn: _appModel.isOn,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(30)),
              child: MySubscribe(
                isOn: _appModel.isOn,
              ),
            ),

            Padding(
                padding:
                    EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(30)),
                child: !_appModel.isFreeEnd
                    ? Countdown(
                        countdownController: countdownController,
                        builder: (_, Duration time) {
                          return Text(
                            '单次免费剩余时间： ${time.inMinutes % 60} 分  ${time.inSeconds % 60} 秒 ',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          );
                        })
                    : Text(
                     LocaleKeys.buttons_freeNodeTip.tr,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    )),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(80)),
              child: const SelectLocation(),
            ),
            Padding(
                padding:
                    EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(80)),
                child: const PowerButton())
          ],
        ));
  }

  Future<dynamic> _nativeCallHandler(MethodCall call) async {
    if (call.method == 'startFreeService') {
      bool callMsg = call.arguments;
      _appModel.isOn = true;
      _appModel.isFreeEnd = false;
      _isLoadingData=false;
      countdownController.start();
      _appModel.notifyListeners();

    }else if(call.method == 'stopFreeService'){
      _appModel.isOn = false;
      _appModel.isFreeEnd = true;
      _isLoadingData=false;
      countdownController.stop();
      print("_______++");
      _appModel.notifyListeners();
    }
    else if (call.method == 'startVpnSuccess') {
      bool callMsg = call.arguments;
      _appModel.isOn = true;
      print("_______+");
      _appModel.notifyListeners();
    }
    else if (call.method == 'stopVpnSuccess') {
      bool callMsg = call.arguments;
      _appModel.isOn = false;
      _appModel.isFreeEnd=true;
      countdownController.stop();
      print("____________");
      _appModel.notifyListeners();
    }
  }



  @override
  void dispose() {

    super.dispose();
  }
}

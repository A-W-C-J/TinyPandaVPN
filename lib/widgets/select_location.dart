import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';

import 'package:sail/constant/app_colors.dart';
import 'package:sail/generated/locales.g.dart';
import 'package:sail/models/app_model.dart';

import 'package:sail/utils/navigator_util.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({
    Key? key,
  }) : super(key: key);

  @override
  SelectLocationState createState() => SelectLocationState();
}

class SelectLocationState extends State<SelectLocation> {

  late AppModel _appModel;
  MethodChannel methodsChannel = MethodChannel("com.captain.bestvpn/chaneel");
  String remark = '';


  @override
  initState() {

    methodsChannel.setMethodCallHandler(_nativeCallHandler);
    super.initState();
  }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _appModel = Provider.of<AppModel>(context);
  }

  void getRemarkString() async {
    remark = await getRemark();
  }

  Future<String> getRemark() async {
    return await _appModel.getRemark();
  }

  @override
  Widget build(BuildContext context) {

    getRemarkString();
    Future<void> pressConnectBtn() async {
      _appModel.toggleV2ray();
    }

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 20, horizontal: ScreenUtil().setWidth(75)),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: _appModel.isOn ? Colors.white : AppColors.themeColor,
        child: InkWell(
          // onTap: () {
          //   _userModel.checkHasLogin(context, pressConnectBtn);
          // },
          onTap: () {
            _appModel.toggleV2ray();
          },
          splashColor: Colors.grey,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: _appModel.isOn
                    ? Colors.white
                    : AppColors.yellowColor.withAlpha(200),
                blurRadius: 20,
                spreadRadius: -6,
                offset: const Offset(
                  0.0,
                  3.0,
                ),
              )
            ]),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Row(
              children: [
                _appModel.isOn? const Icon(Icons.sailing):const Icon(Icons.sailing,color: Colors.white),
                Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(10))),
                Text(
                  remark.isNotEmpty ? remark : LocaleKeys.buttons_selectNode.tr,
                  style: _appModel.isOn? const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black):const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white)
                ),
                Expanded(child: Container()),
                _appModel.isOn?const Icon(Icons.chevron_right):const Icon(Icons.chevron_right,color: Colors.white)
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<dynamic> _nativeCallHandler(MethodCall call) async {
    if (call.method == 'setSelectRemark') {
      String callMsg = call.arguments.toString();
      _appModel.isSelect = true;
      _appModel.notifyListeners();
      setState(() {
        remark = callMsg;
      });
    }
  }

}

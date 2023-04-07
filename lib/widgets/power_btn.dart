import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';

import 'package:sail/constant/app_colors.dart';
import 'package:sail/generated/locales.g.dart';
import 'package:sail/models/app_model.dart';

import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sail/widgets/progress_dialog.dart';

class PowerButton extends StatefulWidget {
  const PowerButton({Key? key}) : super(key: key);

  @override
  PowerButtonState createState() => PowerButtonState();
}

class PowerButtonState extends State<PowerButton> {
  late AppModel _appModel;
  late YYDialog yyDialog;



  @override
  void initState() {

    super.initState();
  }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appModel = Provider.of<AppModel>(context);
  }

  Future<void> pressConnectBtn() async {
    yyDialog.show();
    Future.delayed(const Duration(milliseconds: 1000), () {
      yyDialog.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    YYDialog.init(context);
    yyDialog = YYDialog().build()
      ..width = 200
      ..height = 200
      ..borderRadius = 4.0
      ..backgroundColor = Colors.transparent
      ..duration = const Duration(milliseconds: 250)
      ..widget(const Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: Align(
              alignment: Alignment.center,
              child: SpinKitRotatingPlain(color: Colors.yellow, size: 100))))
      ..dismissCallBack = () {
        if (!_appModel.isSelect) {
          Fluttertoast.showToast(
              msg: LocaleKeys.buttons_selectNode.tr,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2,
              textColor: Colors.white,
              fontSize: 14.0);
        } else {
          _appModel.togglePowerButton();
        }
      };
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color:
            _appModel.isOn ? const Color(0xFF4CAF50) : const Color(0xFF4CAF50),
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(160)),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(140)),
        color: _appModel.isOn ? AppColors.yellowColor :AppColors.themeColor,
        child: InkWell(
          splashColor: AppColors.yellowColor,
          // onTap: () => _userModel.checkHasLogin(context, pressConnectBtn),
          onTap: () => {
            yyDialog.show(),
            Future.delayed(const Duration(milliseconds: 1000), () {
              yyDialog.dismiss();
            }),
          },
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(140)),
          child: Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
              child: Icon(
                Icons.power_settings_new,
                size: ScreenUtil().setWidth(120),
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}

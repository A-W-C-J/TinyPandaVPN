import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sail/constant/app_colors.dart';
import 'package:sail/entity/user_subscribe_entity.dart';
import 'package:sail/generated/locales.g.dart';
import 'package:sail/models/app_model.dart';
import 'package:sail/utils/transfer_util.dart';

class MySubscribe extends StatefulWidget {
  const MySubscribe({Key? key, required this.isOn}) : super(key: key);

  final bool isOn;

  @override
  MySubscribeState createState() => MySubscribeState();
}

class MySubscribeState extends State<MySubscribe> {
  late AppModel _appModel;

  @override
  void didChangeDependencies() {
    _appModel = Provider.of<AppModel>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: ScreenUtil().setWidth(30)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(10)),
          child: _contentWidget(),
        )
      ],
    );
  }

  Widget _contentWidget() {
    return _emptyWidget();
  }

  Widget _emptyWidget() {
    return Container(
      width: ScreenUtil().setWidth(1080),
      height: ScreenUtil().setWidth(200),
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(75),
          vertical: ScreenUtil().setWidth(0)),
      child: Material(
        elevation: widget.isOn ? 3 : 0,
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
        color: widget.isOn ? Colors.white : AppColors.themeColor,
        child: InkWell(
          onTap: () {
            _appModel.iap("vipnode");
          },
          // child: Row(
          //   children: [
          //     Padding(
          //         padding: EdgeInsets.only(left: ScreenUtil().setWidth(150)),
          //         child: ElevatedButton(
          //           child: Text("去广告"),
          //           onPressed: () {},
          //         )),
          //     const Spacer(),
          //     Padding(
          //         padding: EdgeInsets.only(right: ScreenUtil().setWidth(150)),
          //         child: ElevatedButton(
          //           child: Text("订阅高级线路"),
          //           onPressed: () {},
          //         )),
          //   ],
          // ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              LocaleKeys.buttons_subs.tr,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setWidth(40),
                  color: widget.isOn ? Colors.black : Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

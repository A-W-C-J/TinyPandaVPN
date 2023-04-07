import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:sail/constant/app_colors.dart';
import 'package:sail/generated/locales.g.dart';
import 'package:sail/models/app_model.dart';
import 'package:sail/utils/navigator_util.dart';

class LogoBar extends StatelessWidget {
  const LogoBar({
    Key? key,
    required this.isOn,
  }) : super(key: key);

  final bool isOn;

  @override
  Widget build(BuildContext context) {
    AppModel appModel = Provider.of<AppModel>(context);

    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setWidth(60)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
           LocaleKeys.buttons_name.tr,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: ScreenUtil().setSp(60),
              color: isOn ? AppColors.grayColor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

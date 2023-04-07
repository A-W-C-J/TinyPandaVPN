import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import 'package:provider/provider.dart';


import 'package:sail/constant/app_colors.dart';
import 'package:sail/constant/app_dimens.dart';
import 'package:sail/generated/locales.g.dart';
import 'package:sail/models/app_model.dart';
import 'package:sail/utils/navigator_util.dart';
import 'package:get/get.dart';
import 'package:sail/widgets/home_widget.dart';
import 'package:sail/widgets/power_btn.dart';
import 'package:sail/utils/common_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late AppModel _appModel;
  bool _isLoadingData = false;
  bool _initialStatus = false;
  final GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();
  DateTime? _lastPressedAt;


  bool isAdLoaded = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }



  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    print('state = $state');
    if (state == AppLifecycleState.resumed) {
      _appModel.getStatus();
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _appModel = Provider.of<AppModel>(context);
    if (!_isLoadingData) {
      _isLoadingData = true;
      // _appModel.sendUpdateSubBroadcast();
      // _appModel.sendSelectBroadcast();
    }
    if (!_initialStatus) {
      _initialStatus = true;
      _appModel.getStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: const Size(AppDimens.maxWidth, AppDimens.maxHeight));
    return WillPopScope(
      onWillPop: () async {
        if (_key.currentState!.isDrawerOpen) {
          _key.currentState!.closeSlider();
          return false;
        } else if (!_key.currentState!.isDrawerOpen) {
          _key.currentState!.toggle();
          return false;
        } else {
          return true;
        }
      },
      child: Container(
        alignment: Alignment.center,
        child: Scaffold(
            body: SliderDrawer(
          key: _key,
          appBar: SliderAppBar(
              appBarColor: _appModel.isOn
                  ? AppColors.yellowColor
                  : Colors.white,
              isTitleCenter: true,
              drawerIconColor:
                  _appModel.isOn ? AppColors.darkSurfaceColor : Colors.black,
              title: Text("TinyPandaVPN",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: _appModel.isOn
                          ? AppColors.darkSurfaceColor
                          : Colors.white))),
          slider: _SliderView(
            onItemClick: (id) {
              () => _key.currentState!.closeSlider();
              if (id == 5) {
                _appModel.toggleSettingButton();
              } else if (id == 4) {
                NavigatorUtil.goWebView(
                    context, "隐私政策", "https://tinypanda-20e1f.web.app/privacy-policy.html");
              }else if (id == 6) {
                _appModel.toggleLogButton();
              }
            },
            isOn: _appModel.isOn,
          ),
          child: Container(
            color: Colors.amber,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: _appModel.isOn
                    ? SystemUiOverlayStyle.dark
                    : SystemUiOverlayStyle.light,
                child: Scaffold(
                  extendBody: true,
                  backgroundColor: _appModel.isOn
                      ? AppColors.yellowColor
                      : AppColors.grayColor,
                  body: SafeArea(
                      bottom: false,
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _appModel.pageController,
                        children: const [HomeWidget()],
                      )),
                )),
          ),
        )),
      ),
    );
  }
}

class _SliderView extends StatelessWidget {
  final Function(int)? onItemClick;
  final bool isOn;

  const _SliderView({Key? key, this.onItemClick, required this.isOn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isOn ? AppColors.themeColor : AppColors.darkSurfaceColor,
      padding: const EdgeInsets.only(top: 30),
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          CircleAvatar(
            radius: 65,
            backgroundColor: Colors.grey,
            child: CircleAvatar(
                radius: 60,
                backgroundImage:
                    Image.asset("assets/images/play_store.png").image),
          ),
          const SizedBox(
            height: 20,
          ),
          // const Text(
          //   "dddd",
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     color: Colors.black,
          //     fontWeight: FontWeight.bold,
          //     fontSize: 30,
          //   ),
          // ),
          const SizedBox(
            height: 20,
          ),
          ...[
            Menu(Icons.settings, LocaleKeys.buttons_setting.tr, 5),
            Menu(Icons.privacy_tip, LocaleKeys.buttons_Privacy_Policy.tr, 4),
            Menu(Icons.logo_dev, LocaleKeys.buttons_Log.tr, 6),

          ]
              .map((menu) => _SliderMenuItem(
                  title: menu.title,
                  iconData: menu.iconData,
                  id: menu.id,
                  onTap: onItemClick, isOn: isOn,))
              .toList(),
        ],
      ),
    );
  }
}

class _SliderMenuItem extends StatelessWidget {
  final String title;
  final int id;
  final IconData iconData;
  final Function(int)? onTap;
  final bool isOn;

  const _SliderMenuItem(
      {Key? key,
      required this.title,
      required this.id,
      required this.iconData,
      required this.onTap,
      required this.isOn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title,
            style: isOn?const TextStyle(
                color: Colors.white, fontFamily: 'BalsamiqSans_Regular'):const TextStyle(
                color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
        leading: isOn?Icon(iconData, color: Colors.white):Icon(iconData, color: Colors.black),
        onTap: () => onTap?.call(id));
  }
}

class Menu {
  final IconData iconData;
  final String title;
  final int id;

  Menu(this.iconData, this.title, this.id);
}

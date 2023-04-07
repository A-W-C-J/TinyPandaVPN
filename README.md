## TinyPanda VPN

一个Android端基于 [AndroidLibV2rayLite](https://github.com/2dust/AndroidLibV2rayLite) 以及 [sail](https://github.com/sail-tunnel/sail) 的VPN 

<a href="https://play.google.com/store/apps/details?id=com.caption.bestvpn"><img width="200px" alt="Get it on Google Play" src="https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png"/></a>

### 注意
- 删除了Sail对V2board面板的支持，节点数据现在完全靠远程下发第三方订阅链接。如需对接V2board,请参考Sail自行修改
- 删除原Sail项目采用的[Leaf](https://github.com/eycorsican/leaf)内核，换用[AndroidLibV2rayLite](https://github.com/2dust/AndroidLibV2rayLite)
- AndroidLibV2rayLite相关libv2ray.aar以及libtun2socks.so 文件请移步[AndroidLibV2rayLite](https://github.com/2dust/AndroidLibV2rayLite)自行编译，原作者不鼓励提供已编译版本

### 环境
- Flutter 3.3.9
- Dart 2.18.5

### 感谢
- [AndroidLibV2rayLite](https://github.com/2dust/AndroidLibV2rayLite)
- [sail](https://github.com/sail-tunnel/sail)


import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

YYDialog YYProgressDialogNoBody() {
  return YYDialog().build()
    ..width = 200
    ..borderRadius = 4.0
    ..backgroundColor=Colors.transparent
    ..duration=Duration(milliseconds: 3000)
    ..circularProgress(
      padding: EdgeInsets.all(24.0),
      valueColor: Colors.orange[500],
    )
    ..show();
}
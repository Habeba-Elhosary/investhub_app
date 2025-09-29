// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../util/navigator.dart';

Future<bool?> showNoContextDialog({
  required AppNavigator navigator,
  required Widget child,
  double? borderRadius,
  bool isDismissible = true,
}) {
  return showDialog<bool?>(
    context: navigator.navigatorKey.currentContext!,
    barrierDismissible: isDismissible,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
        ),
        child: WillPopScope(onWillPop: () async => isDismissible, child: child),
      );
    },
  );
}

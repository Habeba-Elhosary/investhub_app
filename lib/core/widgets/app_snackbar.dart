import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/fonts.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showAppSnackBar({
  required BuildContext context,
  required String message,
  required ToastType type,
  SnackBarBehavior? behavior = SnackBarBehavior.floating,
  Duration duration = const Duration(milliseconds: 1750),
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    buildAppSnackBar(
      context: context,
      message: message,
      type: type,
      behavior: behavior,
      duration: duration,
    ),
  );
}

SnackBar buildAppSnackBar({
  required BuildContext context,
  required String message,
  required ToastType type,
  required SnackBarBehavior? behavior,
  required Duration duration,
}) {
  return SnackBar(
    content: _buildContent(message, type),
    dismissDirection: DismissDirection.horizontal,
    padding: _padding,
    margin: _getMargin(context, behavior),
    backgroundColor: type.color,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    behavior: behavior,
    duration: duration,
    elevation: 0.0,
  );
}

Widget _buildContent(String message, ToastType type) {
  return Wrap(
    crossAxisAlignment: WrapCrossAlignment.center,
    children: <Widget>[
      Icon(type.icon, color: AppColors.white, size: 32.r),
      SizedBox(width: 8.w),
      Text(
        message,
        style: TextStyles.regular16
            .copyWith(color: AppColors.white)
            .copyWith(fontFamily: AppFonts.tajawal),
        overflow: TextOverflow.clip,
      ),
    ],
  );
}

EdgeInsetsGeometry get _padding =>
    EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h);

EdgeInsetsGeometry? _getMargin(
  BuildContext context,
  SnackBarBehavior? behavior,
) {
  if (behavior != SnackBarBehavior.floating) {
    return null;
  }
  return EdgeInsetsDirectional.only(bottom: 16.h, start: 16.w, end: 16.w);
}

enum ToastType { success, error, warning, info }

extension ToastTypeColor on ToastType {
  Color get color {
    switch (this) {
      case ToastType.success:
        return AppColors.success;
      case ToastType.error:
        return AppColors.red;
      case ToastType.warning:
        return AppColors.warning;
      case ToastType.info:
        return AppColors.info;
    }
  }

  IconData get icon {
    switch (this) {
      case ToastType.success:
        return Icons.check_circle_rounded;
      case ToastType.error:
        return Icons.error_rounded;
      case ToastType.warning:
        return Icons.warning_rounded;
      case ToastType.info:
        return Icons.info_rounded;
    }
  }
}

import 'dart:ui';

import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDialogs {
  static Future<T?> showAppSheet<T>(BuildContext context, Widget child) {
    return showModalBottomSheet<T>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
      builder: (BuildContext context) => child,
    );
  }

  static Future<T?> showAppDialog<T>(
    BuildContext context,
    Widget child, {
    bool? isDismissible = true,
    EdgeInsetsGeometry? padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 20,
    ),
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: isDismissible ?? true,
      builder: (BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Padding(
          padding: SizeConfig.paddingSymmetric,
          child: Material(
            type: MaterialType.transparency,
            child: Center(
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: padding,
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Future<T?> showMainDialog<T>(
    BuildContext context,
    Widget child, {
    bool? isDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: isDismissible ?? true,
      builder: (BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Padding(
          padding: SizeConfig.paddingSymmetric,
          child: Material(
            type: MaterialType.transparency,
            child: Center(child: SafeArea(child: child)),
          ),
        ),
      ),
    );
  }

  static Future<T?> showDialogWithAnimation<T>(
    BuildContext context,
    Widget child, {
    bool isDismissible = true,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: isDismissible,
      barrierColor: Colors.black.withValues(alpha: 0.5), // Background fade
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Material(
                  type: MaterialType.transparency,
                  child: Center(child: SafeArea(child: child)),
                ),
              ),
            );
          },
      transitionBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            const double begin = 0.0;
            const double end = 1.0;
            const Curve curve = Curves.easeInOut;

            final Tween<double> opacityTween = Tween(begin: begin, end: end);
            final Tween<double> scaleTween = Tween(begin: 0.85, end: end);

            final Animation<double> curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return FadeTransition(
              opacity: opacityTween.animate(curvedAnimation),
              child: ScaleTransition(
                scale: scaleTween.animate(curvedAnimation),
                child: child,
              ),
            );
          },
    );
  }

  static Future<T?> showAppGiftDialog<T>(BuildContext context, Widget child) {
    return showDialog<T>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Material(
          type: MaterialType.transparency,
          child: Center(child: child),
        ),
      ),
    );
  }
}

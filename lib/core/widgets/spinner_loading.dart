import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpinnerLoading extends StatelessWidget {
  const SpinnerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.imagesSplashLogo,
      // AppAssets.imagesSpinnerLoading,
      height: 60.h,
      width: 60.w,
      color: AppColors.primary,
    );
  }
}

import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppAssets.imagesLogo, height: 110.sp),
        const AppSpacer(heightRatio: 1.5),
        Text(title, style: TextStyles.bold24),
        const AppSpacer(heightRatio: 0.5),
        Text(
          subtitle,
          style: TextStyles.regular16.copyWith(color: Color(0xff5A6076)),
        ),
      ],
    );
  }
}

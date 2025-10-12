import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/size_config.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';

class StaticDataScreen extends StatelessWidget {
  final String title;
  const StaticDataScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), elevation: 0.2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: SizeConfig.paddingSymmetric,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.app_name.tr(),
                    style: TextStyles.bold24.copyWith(
                      color: AppColors.primary,
                      fontStyle: FontStyle.italic,
                      fontSize: 27.sp,
                    ),
                  ),
                  Image.asset(
                    AppAssets.logo,
                    height: 30.sp,
                    color: AppColors.primary,
                  ),
                ],
              ),
              AppSpacer(heightRatio: 1),
              Text(
                title == LocaleKeys.profile_about_us.tr() 
                    ? LocaleKeys.about_us_content.tr()
                    : LocaleKeys.about_app_content.tr(),
                style: TextStyles.regular16.copyWith(height: 2.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

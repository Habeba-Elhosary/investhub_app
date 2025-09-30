import 'package:easy_localization/easy_localization.dart';
import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showlogo;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.showlogo = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showlogo) ...[
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
                AppAssets.imagesSplashLogo,
                height: 30.sp,
                color: AppColors.primary,
              ),
            ],
          ),
          const AppSpacer(heightRatio: 1.5),
        ],
        Text(title, style: TextStyles.bold22),
        const AppSpacer(heightRatio: 0.5),
        Text(
          subtitle,
          style: TextStyles.regular16.copyWith(color: AppColors.lightGrey),
        ),
      ],
    );
  }
}

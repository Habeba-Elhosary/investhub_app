import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/auth/presentation/pages/sign_in/sign_in_screen.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VisitorPopupWidget extends StatelessWidget {
  const VisitorPopupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSpacer(heightRatio: 1),
        Image.asset(AppAssets.imagesVistor, width: 120.sp),
        AppSpacer(heightRatio: 1),
        Text(
          LocaleKeys.login_to_become_a_seller.tr(),
          style: TextStyles.bold16,
        ),
        AppSpacer(heightRatio: 1),
        Text(
          LocaleKeys.login_to_become_a_seller_message.tr(),
          style: TextStyles.regular14,
          textAlign: TextAlign.center,
        ),
        AppSpacer(heightRatio: 1),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: () {
              appNavigator.push(screen: const SignInScreen());
            },
            child: Text(LocaleKeys.auth_signin.tr()),
          ),
        ),
      ],
    );
  }
}

import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AppAssets.imagesCart, height: 170.sp),
          AppSpacer(heightRatio: 1),
          Text(LocaleKeys.cart_cart_empty.tr(), style: TextStyles.bold20),
          AppSpacer(heightRatio: 1),
          Text(
            LocaleKeys.cart_cart_start_adding.tr(),
            style: TextStyles.regular16.copyWith(color: AppColors.lightGrey),
          ),
        ],
      ),
    );
  }
}

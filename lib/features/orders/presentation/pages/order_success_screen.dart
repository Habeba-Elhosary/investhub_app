import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/size_config.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/contact_dialog.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.order_congratulations.tr())),
      body: SafeArea(
        child: Padding(
          padding: SizeConfig.paddingSymmetric,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Image.asset(AppAssets.imagesSuccess, height: 200.sp),
              AppSpacer(heightRatio: 0.5),
              Text(
                LocaleKeys.order_order_sent_to_management.tr(),
                style: TextStyles.bold20,
              ),
              AppSpacer(heightRatio: 0.5),
              Text(
                LocaleKeys.order_order_sent_message.tr(),
                style: TextStyles.regular18.copyWith(color: AppColors.greyHint),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.order_contact_management.tr(),
                    style: TextStyles.regular18.copyWith(
                      color: AppColors.greyHint,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      appNavigator.showSheet(child: ContactBottomSheet());
                    },
                    child: Container(
                      padding: EdgeInsets.all(15.sp),
                      decoration: BoxDecoration(
                        color: Color(0XFF11B749),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssets.imagesCallMangment,
                          width: 35.sp,
                          height: 35.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              AppSpacer(heightRatio: 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    appNavigator.popToFrist();
                  },
                  child: Text(LocaleKeys.order_go_to_home.tr()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/size_config.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/home/presentation/pages/opportunity_details_screen.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';

class OpportunitiesScreen extends StatelessWidget {
  const OpportunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.home_oppurtunities.tr()),
        elevation: 0.2,
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const AppSpacer(heightRatio: 0.5),
        padding: SizeConfig.paddingSymmetric,
        itemCount: 10,
        itemBuilder: (context, index) {
          return OpportunityCard();
        },
      ),
    );
  }
}

class OpportunityCard extends StatelessWidget {
  const OpportunityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.greyLight.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.sp,
                  vertical: 7.sp,
                ),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(40.r),
                ),
                child: Text(
                  'السوق السعودي',
                  style: TextStyles.regular14.copyWith(
                    color: AppColors.acceptText,
                  ),
                ),
              ),
            ],
          ),
          AppSpacer(heightRatio: 0.7),
          Text(
            'شركة أرامكو السعودية',
            style: TextStyles.bold20.copyWith(color: AppColors.primary),
          ),
          AppSpacer(heightRatio: 0.7),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.sp,
                    vertical: 15.sp,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('السعر الحالي', style: TextStyles.regular16),
                      AppSpacer(heightRatio: 0.7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '2300.0',
                            style: TextStyles.bold22.copyWith(fontSize: 30.sp),
                          ),
                          AppSpacer(widthRatio: 0.5),
                          Image.asset(
                            AppAssets.imagesSaudiRiyalSymbol,
                            height: 18.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              AppSpacer(widthRatio: 0.5),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.sp,
                    vertical: 15.sp,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('سعر الدخول', style: TextStyles.regular16),
                      AppSpacer(heightRatio: 0.7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '2300.0',
                            style: TextStyles.bold22.copyWith(fontSize: 30.sp),
                          ),
                          AppSpacer(widthRatio: 0.5),
                          Image.asset(
                            AppAssets.imagesSaudiRiyalSymbol,
                            height: 18.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          AppSpacer(heightRatio: 0.7),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.flip(
                flipY: true,
                child: Icon(
                  Icons.show_chart_rounded,
                  color: AppColors.primary,
                  size: 20.sp,
                ),
              ),
              AppSpacer(widthRatio: 0.3),
              Text('العائد المتوقع : '),
              Spacer(),
              Text(
                '+50 %',
                style: TextStyles.bold20.copyWith(color: AppColors.green),
              ),
            ],
          ),
          AppSpacer(heightRatio: 0.7),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                appNavigator.push(screen: OpportunityDetailsScreen());
              },
              child: Text(LocaleKeys.opportunity_details.tr()),
            ),
          ),
        ],
      ),
    );
  }
}

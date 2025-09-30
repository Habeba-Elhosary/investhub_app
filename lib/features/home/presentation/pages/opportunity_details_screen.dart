import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/size_config.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';

class OpportunityDetailsScreen extends StatelessWidget {
  const OpportunityDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.opportunity_details.tr()),
        elevation: 0.2,
      ),
      body: SingleChildScrollView(
        padding: SizeConfig.paddingSymmetric,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.unActiveBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.sp).copyWith(bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "سهم شركة أرامكو السعودية",
                          style: TextStyles.bold20,
                        ),
                        AppSpacer(heightRatio: 0.7),
                        Row(
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
                              style: TextStyles.bold20.copyWith(
                                color: AppColors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  AppSpacer(heightRatio: 0.7),
                  Divider(color: AppColors.unActiveBorderColor, thickness: 1.h),
                  AppSpacer(heightRatio: 0.7),
                  Padding(
                    padding: EdgeInsets.all(16.sp).copyWith(top: 0),
                    child: Column(
                      spacing: 16.sp,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("السعر الحالي", style: TextStyles.regular16),
                            Spacer(),
                            Text('3500.0', style: TextStyles.semiBold18),
                            AppSpacer(widthRatio: 0.5),
                            Image.asset(
                              AppAssets.imagesSaudiRiyalSymbol,
                              height: 18.sp,
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("سعر الدخول", style: TextStyles.regular16),
                            Spacer(),
                            Text('3500.0', style: TextStyles.semiBold18),
                            AppSpacer(widthRatio: 0.5),
                            Image.asset(
                              AppAssets.imagesSaudiRiyalSymbol,
                              height: 18.sp,
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("السعر المستهدف", style: TextStyles.regular16),
                            Spacer(),
                            Text('3500.0', style: TextStyles.semiBold18),
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
                ],
              ),
            ),
            AppSpacer(heightRatio: 1),
            Container(
              padding: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.unActiveBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("حول الفرصة", style: TextStyles.bold18),
                      Spacer(),
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
                    "فرصة استثمارية واعدة في أسهم شركة أرامكو السعودية، الرائدة عالمياً في مجال الطاقة. "
                    "تتميز الشركة بمركز مالي قوي، سجل نمو ثابت، وتوقعات إيجابية للقطاع. "
                    "هذه الفرصة تهدف إلى تحقيق عوائد رأسمالية جيدة، بالإضافة إلى توزيعات أرباح منتظمة للمستثمرين على المدى المتوسط إلى الطويل.",
                    style: TextStyles.medium18.copyWith(height: 2.sp),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

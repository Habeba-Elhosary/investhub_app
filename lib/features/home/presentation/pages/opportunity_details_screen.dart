import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/size_config.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/home/domain/entities/opportunity.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';

class OpportunityDetailsScreen extends StatelessWidget {
  final Opportunity opportunity;

  const OpportunityDetailsScreen({super.key, required this.opportunity});

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
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Theme.of(context).dividerColor),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.greyLight.withOpacity(0.2)
                        : Theme.of(context).shadowColor.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
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
                          opportunity.companyName,
                          style: TextStyles.bold20.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        AppSpacer(heightRatio: 0.3),
                        Text(
                          opportunity.sectorName,
                          style: TextStyles.regular14.copyWith(
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                          ),
                        ),
                        AppSpacer(heightRatio: 0.7),
                        Row(
                          children: [
                            Transform.flip(
                              flipY: true,
                              child: Icon(
                                Icons.show_chart_rounded,
                                color: Theme.of(context).primaryColor,
                                size: 20.sp,
                              ),
                            ),
                            AppSpacer(widthRatio: 0.3),
                            Text(
                              '${LocaleKeys.expected_return.tr()} : ',
                              style: TextStyles.regular16.copyWith(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '+${opportunity.expectedReturnPercentage}%',
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
                  Divider(
                    color: Theme.of(context).dividerColor,
                    thickness: 1.h,
                  ),
                  AppSpacer(heightRatio: 0.7),
                  Padding(
                    padding: EdgeInsets.all(16.sp).copyWith(top: 0),
                    child: Column(
                      spacing: 16.sp,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.current_price.tr(),
                              style: TextStyles.regular16.copyWith(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                              ),
                            ),
                            Spacer(),
                            Text(
                              opportunity.currentPrice,
                              style: TextStyles.semiBold18.copyWith(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                              ),
                            ),
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
                            Text(
                              LocaleKeys.entry_price.tr(),
                              style: TextStyles.regular16.copyWith(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                              ),
                            ),
                            Spacer(),
                            Text(
                              opportunity.entryPrice,
                              style: TextStyles.semiBold18.copyWith(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                              ),
                            ),
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
                            Text(
                              LocaleKeys.target_price.tr(),
                              style: TextStyles.regular16.copyWith(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                              ),
                            ),
                            Spacer(),
                            Text(
                              _calculateTargetPrice(opportunity),
                              style: TextStyles.semiBold18.copyWith(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                              ),
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
                ],
              ),
            ),
            AppSpacer(heightRatio: 1),
            Container(
              padding: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Theme.of(context).dividerColor),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.greyLight.withOpacity(0.2)
                        : Theme.of(context).shadowColor.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        LocaleKeys.about_opportunity.tr(),
                        style: TextStyles.bold18.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.sp,
                          vertical: 7.sp,
                        ),
                        decoration: BoxDecoration(
                          color: opportunity.isHalal
                              ? AppColors.green.withOpacity(0.1)
                              : Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                        child: Text(
                          opportunity.marketName,
                          style: TextStyles.regular14.copyWith(
                            color: opportunity.isHalal
                                ? AppColors.acceptText
                                : Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      AppSpacer(widthRatio: 0.5),
                      if (opportunity.isHalal)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.sp,
                            vertical: 4.sp,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            LocaleKeys.halal.tr(),
                            style: TextStyles.regular12.copyWith(
                              color: AppColors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  AppSpacer(heightRatio: 0.7),
                  Text(
                    opportunity.description,
                    style: TextStyles.medium18.copyWith(
                      height: 2.sp,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
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

  String _calculateTargetPrice(Opportunity opportunity) {
    try {
      final currentPrice = double.parse(opportunity.currentPrice);
      final expectedReturn = double.parse(opportunity.expectedReturnPercentage);
      final targetPrice = currentPrice * (1 + expectedReturn / 100);
      return targetPrice.toStringAsFixed(2);
    } catch (e) {
      return opportunity.currentPrice;
    }
  }
}

// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/size_config.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Subscription> subscriptions = [
      Subscription(
        title: 'اشتراك شهري',
        description: '1 شهر من المزايا',
        price: 500,
        isPopular: false,
      ),
      Subscription(
        title: 'اشتراك نص سنوي',
        description: '6 أشهر من الراحة والتوفير',
        price: 1300,
        isPopular: true,
      ),
      Subscription(
        title: 'اشتراك سنوي',
        description: '12 شهر بأفضل سعر',
        price: 2400,
        isPopular: false,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.home_subscriptions.tr()),
        elevation: 0.2,
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const AppSpacer(heightRatio: 1.5),
        padding: SizeConfig.paddingSymmetric,
        itemCount: subscriptions.length,
        itemBuilder: (context, index) {
          return SubscriptionCard(subscription: subscriptions[index]);
        },
      ),
    );
  }
}

class Subscription {
  final String title;
  final double price;
  final bool isPopular;
  final String description;
  Subscription({
    required this.title,
    required this.price,
    required this.description,
    required this.isPopular,
  });
}

class SubscriptionCard extends StatelessWidget {
  final Subscription subscription;
  const SubscriptionCard({super.key, required this.subscription});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
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
            border: subscription.isPopular
                ? Border.all(color: AppColors.primary)
                : null,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (subscription.isPopular) SizedBox(height: 20.sp),
              CircleAvatar(
                radius: 18.r,
                backgroundColor: AppColors.grey,
                child: Icon(Icons.star_rounded, color: AppColors.primary),
              ),
              AppSpacer(heightRatio: 0.7),
              Text(subscription.title, style: TextStyles.bold20),
              AppSpacer(heightRatio: 0.3),
              Text(
                subscription.description,
                style: TextStyles.regular16.copyWith(color: AppColors.greyDark),
              ),
              AppSpacer(heightRatio: 0.7),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    subscription.price.toString(),
                    style: TextStyles.bold24.copyWith(fontSize: 40.sp),
                  ),
                  AppSpacer(widthRatio: 0.5),
                  Image.asset(AppAssets.imagesSaudiRiyalSymbol, height: 18.sp),
                ],
              ),
              AppSpacer(heightRatio: 0.7),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(LocaleKeys.subscribe_now.tr()),
                ),
              ),
            ],
          ),
        ),
        if (subscription.isPopular)
          Positioned(
            top: -14,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 10.sp,
                  vertical: 10.sp,
                ),
                child: Text(
                  "الأكثر شعبية",
                  style: TextStyles.bold12.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

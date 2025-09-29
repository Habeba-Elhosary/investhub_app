import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/auth/domain/entities/onboarding_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingItem extends StatelessWidget {
  final OnBoardingEntity entity;
  const OnBoardingItem({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          entity.image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 150.sp,
                left: 16.sp,
                right: 16.sp,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    entity.title,
                    style: TextStyles.bold24.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  AppSpacer(heightRatio: 1),
                  Text(
                    entity.subTitle,
                    style: TextStyles.medium16.copyWith(
                      color: Colors.white,
                      height: 2.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

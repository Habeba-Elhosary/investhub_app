import 'package:investhub_app/core/services/cache_service.dart';
import 'package:investhub_app/features/auth/presentation/pages/sign_in/sign_in_screen.dart';
import 'package:investhub_app/features/auth/presentation/widgets/onborading_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/features/auth/domain/entities/onboarding_entity.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  bool _isLastPage = false;

  final List<OnBoardingEntity> _onBoardingData = [
    OnBoardingEntity(
      title: LocaleKeys.onBoarding_title1.tr(),
      subTitle: LocaleKeys.onBoarding_subtitle1.tr(),
      image: AppAssets.imagesOnboarding1,
    ),
    OnBoardingEntity(
      title: LocaleKeys.onBoarding_title2.tr(),
      subTitle: LocaleKeys.onBoarding_subtitle2.tr(),
      image: AppAssets.imagesOnboarding2,
    ),
  ];

  void _handlePageChange(int index) {
    setState(() {
      _isLastPage = index == _onBoardingData.length - 1;
    });
  }

  void _navigateToSignIn() async {
    await sl<CacheService>().setBool("onboarding_passed", true);
    appNavigator.pushReplacement(screen: const SignInScreen());
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xff303030),
        body: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _onBoardingData.length,
              onPageChanged: _handlePageChange,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return OnBoardingItem(entity: _onBoardingData[index]);
              },
            ),
            Positioned(
              left: 16.sp,
              right: 16.sp,
              bottom: 30.sp,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _navigateToSignIn,
                    child: Text(
                      LocaleKeys.onBoarding_skip.tr(),
                      style: TextStyles.regular18.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15.sp),
                      shape: const CircleBorder(),
                      backgroundColor: AppColors.primary,
                    ),
                    onPressed: () {
                      if (_isLastPage) {
                        _navigateToSignIn();
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.white,
                      size: 25.sp,
                    ),
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

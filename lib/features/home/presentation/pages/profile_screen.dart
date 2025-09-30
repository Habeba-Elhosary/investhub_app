// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/size_config.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/auth/presentation/pages/change_psassword/change_password_screen.dart';
import 'package:investhub_app/features/auth/presentation/pages/sign_up/sign_up_screen.dart';
import 'package:investhub_app/features/auth/presentation/widgets/logout_bottom_sheet.dart';
import 'package:investhub_app/features/home/presentation/pages/static_data_screen.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.home_profile.tr()), elevation: 0.2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: SizeConfig.paddingSymmetric,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: AppColors.primary,
                    child: Icon(
                      Icons.person,
                      size: 30.sp,
                      color: AppColors.white,
                    ),
                  ),
                  AppSpacer(heightRatio: 0.4),
                  Text('John Doe', style: TextStyles.bold20),
                  AppSpacer(heightRatio: 0.2),
                  Text(
                    '05XXXXXXXX',
                    style: TextStyles.regular16.copyWith(
                      color: AppColors.greyHint,
                    ),
                  ),
                  AppSpacer(heightRatio: 0.2),
                  Text(
                    'example@gmail.com',
                    style: TextStyles.regular16.copyWith(
                      color: AppColors.greyHint,
                    ),
                  ),
                ],
              ),
              AppSpacer(heightRatio: 1),
              Container(
                padding: EdgeInsets.all(25.sp),
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
                  spacing: 15.sp,
                  children: [
                    ProfileCardItem(
                      title: LocaleKeys.profile_edit_profile.tr(),
                      image: AppAssets.imagesWrite,
                      onTap: () {
                        appNavigator.push(
                          screen: SignUpScreen(isSignUp: false),
                        );
                      },
                    ),
                    Divider(),
                    ProfileCardItem(
                      title: LocaleKeys.profile_change_password.tr(),
                      image: AppAssets.imagesResetPassword,
                      onTap: () {
                        appNavigator.push(screen: ChangePasswordScreen());
                      },
                    ),
                    Divider(),
                    ProfileCardItem(
                      title: LocaleKeys.profile_change_language.tr(),
                      image: AppAssets.imagesLanguage,
                      onTap: () {},
                    ),
                    Divider(),
                    ProfileCardItem(
                      title: LocaleKeys.profile_change_theme.tr(),
                      image: AppAssets.imagesDarkMode,
                      onTap: () {},
                    ),
                    Divider(),
                    ProfileCardItem(
                      title: LocaleKeys.profile_about_app.tr(),
                      image: AppAssets.imagesInsurance,
                      onTap: () {
                        appNavigator.push(
                          screen: StaticDataScreen(
                            title: LocaleKeys.profile_about_app.tr(),
                          ),
                        );
                      },
                    ),
                    Divider(),
                    ProfileCardItem(
                      title: LocaleKeys.profile_privacy_policy.tr(),
                      image: AppAssets.imagesInsurance,
                      onTap: () {
                        appNavigator.push(
                          screen: StaticDataScreen(
                            title: LocaleKeys.profile_privacy_policy.tr(),
                          ),
                        );
                      },
                    ),
                    Divider(),
                    ProfileCardItem(
                      title: LocaleKeys.profile_log_out.tr(),
                      image: AppAssets.imagesLogout,
                      isLogOut: true,
                      onTap: () {
                        appNavigator.showSheet(child: LogOutBottomSheet());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCardItem extends StatelessWidget {
  final String title;
  final String image;
  final Function() onTap;
  final bool isLogOut;
  const ProfileCardItem({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
    this.isLogOut = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            image,
            height: 20.sp,
            width: 20.sp,
            color: isLogOut ? AppColors.red : AppColors.primary,
          ),
          AppSpacer(widthRatio: 0.7),
          Text(
            title,
            style: TextStyles.semiBold16.copyWith(
              color: isLogOut ? AppColors.red : null,
            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20.sp,
            color: isLogOut ? AppColors.red : AppColors.primary,
          ),
        ],
      ),
    );
  }
}

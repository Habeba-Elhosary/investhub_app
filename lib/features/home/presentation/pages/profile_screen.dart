// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/size_config.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/spinner_loading.dart';
import 'package:investhub_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:investhub_app/features/auth/presentation/pages/change_psassword/change_password_screen.dart';
import 'package:investhub_app/features/auth/presentation/pages/sign_in/sign_in_screen.dart';
import 'package:investhub_app/features/auth/presentation/widgets/logout_bottom_sheet.dart';
import 'package:investhub_app/features/home/presentation/cubit/profile/profile_cubit.dart';
import 'package:investhub_app/features/home/presentation/pages/edit_profile_screen.dart';
import 'package:investhub_app/features/home/presentation/pages/static_data_screen.dart';
import 'package:investhub_app/features/home/presentation/widgets/language_bottom_sheet.dart';
import 'package:investhub_app/core/constant/styles/theme/theme_cubit.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => sl<ProfileCubit>()..loadUserData(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.home_profile.tr()),
          elevation: 0.2,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: SizeConfig.paddingSymmetric,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return const Center(child: SpinnerLoading());
                    } else if (state is ProfileSuccess) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30.r,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Icon(
                              Icons.person,
                              size: 30.sp,
                              color: AppColors.white,
                            ),
                          ),
                          AppSpacer(heightRatio: 0.4),
                          Text(
                            state.user.name,
                            style: TextStyles.bold20.copyWith(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                          ),
                          AppSpacer(heightRatio: 0.2),
                          Text(
                            state.user.phone,
                            style: TextStyles.regular16.copyWith(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                            ),
                          ),
                          AppSpacer(heightRatio: 0.2),
                          Text(
                            state.user.email,
                            style: TextStyles.regular16.copyWith(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                            ),
                          ),
                        ],
                      );
                    } else if (state is ProfileError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.message,
                              style: TextStyles.regular16.copyWith(
                                color: AppColors.red,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const AppSpacer(heightRatio: 1),
                            ElevatedButton(
                              onPressed: () {
                                context.read<ProfileCubit>().loadUserData();
                              },
                              child: Text(LocaleKeys.retry.tr()),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                AppSpacer(heightRatio: 1),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12.sp),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
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
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    children: [
                      ProfileCardItem(
                        title: LocaleKeys.profile_edit_profile.tr(),
                        image: AppAssets.imagesWrite,
                        onTap: () {
                          appNavigator.push(screen: EditProfileScreen());
                        },
                      ),
                      Divider(height: 2),
                      ProfileCardItem(
                        title: LocaleKeys.profile_change_password.tr(),
                        image: AppAssets.imagesResetPassword,
                        onTap: () {
                          appNavigator.push(screen: ChangePasswordScreen());
                        },
                      ),
                      Divider(height: 2),
                      ProfileCardItem(
                        title: LocaleKeys.profile_change_language.tr(),
                        image: AppAssets.imagesLanguage,
                        onTap: () {
                          LanguageBottomSheet.show(context);
                        },
                      ),
                      Divider(height: 2),
                      BlocBuilder<ThemeCubit, ThemeState>(
                        builder: (context, themeState) {
                          return ProfileCardItem(
                            title: LocaleKeys.profile_change_theme.tr(),
                            image: AppAssets.imagesDarkMode,
                            onTap: () {
                              context.read<ThemeCubit>().toggleTheme();
                            },
                            trailing: GestureDetector(
                              onTap: () {
                                context.read<ThemeCubit>().toggleTheme();
                              },
                              child: Container(
                                padding: EdgeInsets.all(8.sp),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Icon(
                                  context.read<ThemeCubit>().isDarkMode
                                      ? Icons.dark_mode
                                      : Icons.light_mode,
                                  size: 20.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Divider(height: 2),
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
                      Divider(height: 2),
                      ProfileCardItem(
                        title: LocaleKeys.profile_about_us.tr(),
                        image: AppAssets.imagesInsurance,
                        onTap: () {
                          appNavigator.push(
                            screen: StaticDataScreen(
                              title: LocaleKeys.profile_about_us.tr(),
                            ),
                          );
                        },
                      ),
                      Divider(height: 2),
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
                      Divider(height: 2),
                      ProfileCardItem(
                        title: LocaleKeys.profile_log_out.tr(),
                        image: AppAssets.imagesLogout,
                        isLogOut: true,
                        onTap: () {
                          appNavigator.showSheet(
                            child: LogOutBottomSheet(
                              onLogout: () async {
                                try {
                                  await sl<AuthLocalDataSource>().clearData();
                                  final GoogleSignIn signIn =
                                      GoogleSignIn.instance;
                                  await signIn.signOut();
                                  _logout();
                                } catch (e) {
                                  _logout();
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _logout() {
  appNavigator.popToFrist();
  appNavigator.pushReplacement(screen: SignInScreen());
}

class ProfileCardItem extends StatelessWidget {
  final String title;
  final String image;
  final Function() onTap;
  final bool isLogOut;
  final Widget? trailing;
  const ProfileCardItem({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
    this.isLogOut = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 16.sp, horizontal: 12.w),
        child: Row(
          children: [
            Image.asset(
              image,
              height: 20.sp,
              width: 20.sp,
              color: isLogOut ? AppColors.red : Theme.of(context).primaryColor,
            ),
            AppSpacer(widthRatio: 0.7),
            Text(
              title,
              style: TextStyles.semiBold16.copyWith(
                color: isLogOut
                    ? AppColors.red
                    : Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            Spacer(),
            if (trailing != null)
              trailing!
            else
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20.sp,
                color: isLogOut
                    ? AppColors.red
                    : Theme.of(context).primaryColor,
              ),
          ],
        ),
      ),
    );
  }
}

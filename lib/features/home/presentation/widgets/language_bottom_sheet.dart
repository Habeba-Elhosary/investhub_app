import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/size_config.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/restart_widget.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';

class LanguageBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) {
        String selectedLanguage = context.locale.languageCode;
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: SizeConfig.paddingSymmetric,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppSpacer(heightRatio: 2),
                  Center(
                    child: Text(
                      LocaleKeys.profile_change_language.tr(),
                      style: TextStyles.bold20.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  AppSpacer(heightRatio: 1),

                  Image.asset(
                    AppAssets.imagesLanguage,
                    width: 100.sp,
                    height: 100.sp,
                    color: AppColors.primary,
                  ),
                  AppSpacer(heightRatio: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildLanguageOption(
                        flag: '🇪🇬',
                        label: 'العربية',

                        isSelected: selectedLanguage == 'ar',
                        onTap: () => setState(() => selectedLanguage = 'ar'),
                      ),
                      AppSpacer(widthRatio: 0.7),
                      _buildLanguageOption(
                        label: 'English',
                        flag: '🇺🇸',
                        isSelected: selectedLanguage == 'en',
                        onTap: () => setState(() => selectedLanguage = 'en'),
                      ),
                    ],
                  ),

                  AppSpacer(heightRatio: 1),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedLanguage == 'ar') {
                          context.setLocale(const Locale('ar'));
                        } else {
                          context.setLocale(const Locale('en'));
                        }
                        RestartWidget.restartApp(context);
                        appNavigator.pop();
                      },
                      child: Text(LocaleKeys.confirm.tr()),
                    ),
                  ),
                  AppSpacer(heightRatio: 1),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static Widget _buildLanguageOption({
    required String label,
    required String flag,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.unActiveBorderColor,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: isSelected
                    ? AppColors.primary
                    : AppColors.unActiveBorderColor,
              ),

              AppSpacer(widthRatio: 1.5),
              Text(
                label,
                style: TextStyles.regular16.copyWith(
                  color: AppColors.darkPrimary,
                ),
              ),
              AppSpacer(widthRatio: 1.5),
              Text(flag, style: TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
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
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppSpacer(heightRatio: 3),
                      Expanded(
                        child: Center(
                          child: Text(
                            'LocaleKeys.student_profile_select_language.tr()',
                            style: TextStyles.bold18,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => appNavigator.pop(),
                        child: Icon(Icons.close, color: AppColors.primary),
                      ),
                    ],
                  ),

                  AppSpacer(heightRatio: 2),
                  Image.asset(
                    AppAssets.imagesLanguage,
                    width: 100.sp,
                    height: 100.sp,
                  ),

                  AppSpacer(heightRatio: 2),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildLanguageOption(
                        flag: '🇪🇬',
                        label: 'العربية',

                        isSelected: selectedLanguage == 'ar',
                        onTap: () => setState(() => selectedLanguage = 'ar'),
                      ),
                      _buildLanguageOption(
                        label: 'English',
                        flag: '🇺🇸',
                        isSelected: selectedLanguage == 'en',
                        onTap: () => setState(() => selectedLanguage = 'en'),
                      ),
                    ],
                  ),

                  AppSpacer(heightRatio: 2),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedLanguage == 'ar') {
                          context.setLocale(const Locale('ar'));
                        } else {
                          context.setLocale(const Locale('en'));
                        }
                        // context
                        //     .read<GetEducationDataCubit>()
                        //     .getEducationDataEvent();
                        appNavigator.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E56A0),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        LocaleKeys.confirm.tr(),
                        style: TextStyles.bold16,
                      ),
                    ),
                  ),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? Color(0xFF1E56A0) : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected ? Color(0xFF1E56A0) : Colors.grey,
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
    );
  }
}

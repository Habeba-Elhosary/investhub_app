import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../values/colors.dart';
import '../values/fonts.dart';
import '../values/size_config.dart';
import '../values/text_styles.dart';

class AppLightTheme {
  static AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: AppColors.white,
    centerTitle: true,
    elevation: 0,
    toolbarHeight: 70.h,
    iconTheme: IconThemeData(color: AppColors.primary),
    foregroundColor: AppColors.black,
    actionsIconTheme: IconThemeData(color: AppColors.primary),
    titleTextStyle: TextStyles.bold20.copyWith(
      fontFamily: AppFonts.tajawal,
      color: Color(0xff2D3846),
    ),
  );

  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      textStyle: TextStyles.bold16.copyWith(fontFamily: AppFonts.tajawal),
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.hPadding,
        vertical: 18.sp,
      ),
    ),
  );

  static OutlinedButtonThemeData outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      textStyle: TextStyles.bold16.copyWith(fontFamily: AppFonts.tajawal),
      foregroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.hPadding,
        vertical: 18.sp,
      ),
      side: BorderSide(color: AppColors.primary),
    ),
  );

  static DropdownMenuThemeData dropdownMenuThemeData = DropdownMenuThemeData(
    textStyle: TextStyles.regular12,
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      hintStyle: TextStyles.regular12.copyWith(color: AppColors.lightGrey),
      filled: true,
      fillColor: AppColors.textFormFieldBG,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColors.unActiveBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColors.unActiveBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColors.primary),
      ),
    ),
  );

  static ThemeData mainThemeData = ThemeData(
    useMaterial3: false,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (context) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.unActiveBorderColor),
          ),
          child: Center(
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.primary,
              size: 18.sp,
            ),
          ),
        );
      },
    ),
    cardColor: Color(0xffF6F6F6),
    scaffoldBackgroundColor: AppColors.white,
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      suffixIconColor: AppColors.greyLight,
      hintStyle: TextStyles.regular16.copyWith(color: AppColors.lightGrey),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColors.red),
      ),
      filled: true,
      fillColor: AppColors.textFormFieldBG,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      labelStyle: TextStyles.regular14,
      floatingLabelStyle: TextStyles.semiBold16.copyWith(
        color: AppColors.primary,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColors.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColors.unActiveBorderColor),
      ),
    ),
    dropdownMenuTheme: dropdownMenuThemeData,
    fontFamily: AppFonts.tajawal,
    primaryColor: AppColors.primary,
    appBarTheme: appBarTheme,
    outlinedButtonTheme: outlinedButtonTheme,
    elevatedButtonTheme: elevatedButtonTheme,
  );
}

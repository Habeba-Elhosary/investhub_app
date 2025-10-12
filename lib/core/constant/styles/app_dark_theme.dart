import 'package:flutter/material.dart';
import 'package:investhub_app/core/constant/values/colors.dart';

class AppDarkTheme {
  static ThemeData get mainThemeData => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.darkCard,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: AppColors.white),
      displayMedium: TextStyle(color: AppColors.white),
      displaySmall: TextStyle(color: AppColors.white),
      headlineLarge: TextStyle(color: AppColors.white),
      headlineMedium: TextStyle(color: AppColors.white),
      headlineSmall: TextStyle(color: AppColors.white),
      titleLarge: TextStyle(color: AppColors.white),
      titleMedium: TextStyle(color: AppColors.white),
      titleSmall: TextStyle(color: AppColors.white),
      bodyLarge: TextStyle(color: AppColors.white),
      bodyMedium: TextStyle(color: AppColors.white),
      bodySmall: TextStyle(color: AppColors.white),
      labelLarge: TextStyle(color: AppColors.white),
      labelMedium: TextStyle(color: AppColors.white),
      labelSmall: TextStyle(color: AppColors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkInput,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.greyLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.greyLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primaryDark),
      ),
      hintStyle: const TextStyle(color: AppColors.greyHint),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.greyLight,
      thickness: 1,
    ),
  );
}

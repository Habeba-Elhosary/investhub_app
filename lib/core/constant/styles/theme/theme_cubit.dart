import 'package:investhub_app/core/constant/styles/app_dark_theme.dart';
import 'package:investhub_app/core/constant/styles/app_light_theme.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/services/theme_cache_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(LightAppTheme()) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      final isDarkMode = await ThemeCacheService.loadThemeMode();
      if (isDarkMode) {
        emit(DarkAppTheme());
      } else {
        emit(LightAppTheme());
      }
    } catch (e) {
      emit(LightAppTheme());
    }
  }

  void changeTheme(ThemeState themeState) {
    emit(themeState);
    _saveTheme(themeState);
  }

  void toggleTheme() {
    if (state is LightAppTheme) {
      emit(DarkAppTheme());
      _saveTheme(DarkAppTheme());
    } else {
      emit(LightAppTheme());
      _saveTheme(LightAppTheme());
    }
  }

  Future<void> _saveTheme(ThemeState themeState) async {
    try {
      final isDarkMode = themeState is DarkAppTheme;
      await ThemeCacheService.saveThemeMode(isDarkMode);
    } catch (_) {}
  }

  bool get isDarkMode => state is DarkAppTheme;
}

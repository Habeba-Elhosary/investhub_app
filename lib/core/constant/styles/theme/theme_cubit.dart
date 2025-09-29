import 'package:investhub_app/core/constant/styles/app_light_theme.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(LightAppTheme());

  void changeTheme(ThemeState themeState) {
    emit(themeState);
  }
}

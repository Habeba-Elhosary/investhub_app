part of 'theme_cubit.dart';

sealed class ThemeState extends Equatable {
  const ThemeState({required this.themeData, required this.primary});

  final ThemeData themeData;
  final Color primary;

  @override
  List<Object?> get props => [themeData, primary];
}

final class LightAppTheme extends ThemeState {
  LightAppTheme()
    : super(themeData: AppLightTheme.mainThemeData, primary: AppColors.primary);
}

// final class DarkAppTheme extends ThemeState {
//   DarkAppTheme()
//       : super(
//           themeData: DarkThemeConfig.mainThemeData,
//           primary: AppColors.primaryDark,
//         );
// }

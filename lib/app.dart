import 'package:investhub_app/core/constant/styles/theme/theme_cubit.dart';
import 'package:investhub_app/core/constant/values/size_config.dart';
import 'package:investhub_app/core/util/font_scale_handler.dart';
import 'package:investhub_app/core/util/navigator.dart';
import 'package:investhub_app/features/auth/presentation/pages/splash/splash_screen.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvestHubApp extends StatelessWidget {
  const InvestHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      fontSizeResolver: (num fontSize, ScreenUtil instance) {
        return FontScaleHandler.calculateFontSize(fontSize.toDouble());
      },
      builder: (BuildContext context, Widget? child) {
        SizeConfig().init(context);
        return MultiBlocProvider(
          providers: ServiceLocator.globalBlocProviders,
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (BuildContext context, ThemeState state) {
              return MaterialApp(
                onGenerateTitle: (BuildContext context) =>
                    LocaleKeys.app_name.tr(),
                theme: state.themeData,
                locale: context.locale,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                navigatorKey: sl<AppNavigator>().navigatorKey,
                home: SplashScreen(),
              );
            },
          ),
        );
      },
    );
  }
}

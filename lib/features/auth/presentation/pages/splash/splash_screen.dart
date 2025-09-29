// ignore_for_file: unnecessary_underscores

import 'package:easy_localization/easy_localization.dart';
import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/auth/presentation/cubits/auto_login/auto_login_cubit.dart';
import 'package:investhub_app/features/auth/presentation/pages/sign_in/sign_in_screen.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _dropController;
  late AnimationController _expansionController;
  late AnimationController _whiteFadeController;
  late AnimationController _fadeImageController;
  late Animation<double> _dropAnim;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeImageAnim;
  final Color splashColor = AppColors.primary;
  final double ballSize = 24.0.sp;
  bool _animationFinished = false;

  @override
  void initState() {
    super.initState();

    _dropController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _expansionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _whiteFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeImageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _dropAnim = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(parent: _dropController, curve: Curves.easeInOut),
    );

    _scaleAnim = Tween<double>(begin: 1.0, end: 50.0).animate(
      CurvedAnimation(parent: _expansionController, curve: Curves.easeIn),
    );

    _fadeImageAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeImageController, curve: Curves.easeIn),
    );

    // Start the drop
    _dropController.forward();

    // When drop finishes → immediately start expansion
    _dropController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _expansionController.forward();
      }
    });

    // After expand → show white
    _expansionController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _whiteFadeController.forward();
      }
    });

    // After white → fade in image
    _whiteFadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fadeImageController.forward();
      }
    });

    // After everything → navigate
    _fadeImageController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        _animationFinished = true;
        _navigateIfReady();
      }
    });
  }

  @override
  void dispose() {
    _dropController.dispose();
    _expansionController.dispose();
    _whiteFadeController.dispose();
    _fadeImageController.dispose();
    super.dispose();
  }

  void _navigateIfReady() {
    // TODO: RETURN

    // final cubit = context.read<AutoLoginCubit>();
    // final state = cubit.state;

    if (!_animationFinished) return;

    appNavigator.pushReplacement(screen: const SignInScreen());

    // if (state is AutoLoginSeenIntro) {
    //   appNavigator.pushReplacement(screen: const SignInScreen());
    // } else if (state is AutoLoginNoUser) {
    //   appNavigator.pushReplacement(screen: const MainScreen());
    // } else if (state is AutoLoginHasUser) {
    // appNavigator.pushReplacement(screen: const MainScreen());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AutoLoginCubit, AutoLoginState>(
      listener: (context, state) {
        _navigateIfReady();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            AnimatedBuilder(
              animation: Listenable.merge([
                _dropController,
                _expansionController,
              ]),
              builder: (_, __) {
                return Align(
                  alignment: Alignment(0, _dropAnim.value),
                  child: Transform.scale(
                    scale: _scaleAnim.value,
                    child: Container(
                      width: ballSize,
                      height: ballSize,
                      decoration: BoxDecoration(
                        color: splashColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              },
            ),
            Center(
              child: FadeTransition(
                opacity: _fadeImageAnim,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.imagesSplashLogo,
                      fit: BoxFit.scaleDown,
                      width: 250.sp,
                    ),
                    Text(
                      LocaleKeys.app_name.tr(),
                      style: TextStyles.bold24.copyWith(
                        color: AppColors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 50.sp,
                      ),
                    ),
                    AppSpacer(heightRatio: 1),
                    Text(
                      LocaleKeys.splash_title1.tr(),
                      style: TextStyles.semiBold24.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    AppSpacer(heightRatio: 1),
                    Text(
                      LocaleKeys.splash_title2.tr(),
                      style: TextStyles.regular20.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

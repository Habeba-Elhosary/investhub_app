// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/custom_stepper.dart';
import 'package:investhub_app/features/auth/presentation/cubits/register/register_cubit.dart';
import 'package:investhub_app/features/auth/presentation/pages/sign_in/sign_in_screen.dart';
import 'package:investhub_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:investhub_app/features/auth/presentation/widgets/register_form_one.dart';
import 'package:investhub_app/features/auth/presentation/widgets/register_form_three.dart';
import 'package:investhub_app/features/auth/presentation/widgets/register_form_two.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';

class SignUpScreen extends StatelessWidget {
  final bool isSignUp;
  const SignUpScreen({super.key, required this.isSignUp});

  @override
  Widget build(BuildContext context) {
    int x = 0;
    return BlocProvider<RegisterCubit>(
      create: (context) => sl<RegisterCubit>(),
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {},
            builder: (context, state) {
              final RegisterCubit registerCubit = context
                  .watch<RegisterCubit>();
              return SingleChildScrollView(
                padding: EdgeInsets.all(16.sp).copyWith(top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (isSignUp) ...[
                      AuthHeader(
                        title: LocaleKeys.auth_create_account.tr(),
                        subtitle: LocaleKeys.auth_create_account_hint.tr(),
                      ),
                    ] else ...[
                      AuthHeader(
                        title: LocaleKeys.profile_edit_profile.tr(),
                        subtitle: LocaleKeys.edit_profile_desc.tr(),
                      ),
                    ],
                    const AppSpacer(heightRatio: 1.5),
                    CustomStepper(
                      currentStep: x,
                      // currentStep: registerCubit.currentStep,
                      steps: [
                        LocaleKeys.auth_personal_info.tr(),
                        LocaleKeys.auth_financial_info.tr(),
                        LocaleKeys.auth_risk_info.tr(args: ['\n']),
                      ],
                    ),
                    AppSpacer(heightRatio: 0.5),
                    buildRegisterForm(registerCubit),
                    AppSpacer(heightRatio: 1),
                    Row(
                      children: [
                        if (x > 0)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              // onPressed: registerCubit.goToPreviousStep,
                              child: Text(LocaleKeys.the_previous.tr()),
                            ),
                          ),

                        if (x > 0) AppSpacer(widthRatio: 0.5),
                        Expanded(
                          child: BlocBuilder<RegisterCubit, RegisterState>(
                            // buildWhen: (previous, current) =>
                            //     current is! RegisterStepChanged,
                            builder: (context, state) {
                              return Visibility(
                                visible: state is! RegisterLoading,
                                // replacement: const SpinnerLoading(),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (x == 0) {
                                      // if (registerCubit
                                      //         .formKeyStep1
                                      //         .currentState
                                      //         ?.validate() ??
                                      //     false) {
                                      // registerCubit.goToNextStep();
                                      // }
                                    } else {
                                      // if (registerCubit
                                      //         .formKeyStep2
                                      //         .currentState
                                      //         ?.validate() ??
                                      //     false) {
                                      // registerCubit.submit();
                                      // }
                                    }
                                  },
                                  child: Text(
                                    x != 2
                                        ? LocaleKeys.the_next.tr()
                                        : LocaleKeys.auth_create_account.tr(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    AppSpacer(heightRatio: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${LocaleKeys.auth_do_you_have_account.tr()} ',
                          style: TextStyles.semiBold16,
                        ),
                        GestureDetector(
                          onTap: () {
                            appNavigator.pushReplacement(
                              screen: SignInScreen(),
                            );
                          },
                          child: Text(
                            LocaleKeys.auth_signin.tr(),
                            style: TextStyles.semiBold16.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget buildRegisterForm(RegisterCubit registerCubit) {
  switch (0) {
    case 0:
      return RegisterFormOne(registerCubit: registerCubit);
    case 1:
      return RegisterFormTwo(registerCubit: registerCubit);
    case 2:
      return RegisterFormThree(registerCubit: registerCubit);
    default:
      return RegisterFormOne(registerCubit: registerCubit);
  }
}

import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/size_config.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/util/validator.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/password_text_form_field.dart';
import 'package:investhub_app/core/widgets/spinner_loading.dart';
import 'package:investhub_app/features/auth/presentation/cubits/detect_user_by_phone/detect_user_by_phone_cubit.dart';
import 'package:investhub_app/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:investhub_app/features/auth/presentation/pages/create_new_password/create_new_password_screen.dart';
import 'package:investhub_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:investhub_app/features/auth/presentation/widgets/call_center_bottomsheet.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: SizeConfig.paddingSymmetric,
        child: BlocProvider<DetectUserByPhoneCubit>(
          create: (context) => sl<DetectUserByPhoneCubit>(),
          child: Builder(
            builder: (context) {
              return BlocBuilder<
                DetectUserByPhoneCubit,
                DetectUserByPhoneState
              >(
                builder: (context, detectUserState) {
                  return SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          AuthHeader(
                            title: LocaleKeys.auth_signin_welcome_message.tr(),
                            subtitle: LocaleKeys.auth_signin_welcome_sub_message
                                .tr(),
                          ),
                          const AppSpacer(heightRatio: 1.5),
                          TextFormField(
                            controller: phoneController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? value) =>
                                Validator.phone(value),
                            keyboardType: TextInputType.phone,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9٠-٩]'),
                              ),
                              LengthLimitingTextInputFormatter(11),
                            ],
                            cursorColor: AppColors.primary,
                            decoration: InputDecoration(
                              labelText: LocaleKeys.auth_phone_number.tr(),
                            ),
                            onChanged: (_) => context
                                .read<DetectUserByPhoneCubit>()
                                .deleteNumber(),
                            onTapOutside: (PointerDownEvent event) {
                              FocusScope.of(context).unfocus();
                            },
                          ),
                          const AppSpacer(heightRatio: 1.5),

                          if (detectUserState
                              is DetectUserByPhoneHasActiveUser) ...[
                            PasswordTextFormField(
                              lable: LocaleKeys.auth_password.tr(),
                              controller: passwordController,
                              validator: (String? value) =>
                                  Validator.password(value),
                            ).animate().slideY(
                              duration: const Duration(milliseconds: 300),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: () {
                                  appNavigator.push(
                                    screen: const CreateNewPasswordScreen(),
                                  );
                                },
                                child: Text(
                                  LocaleKeys.auth_forgot_password.tr(),
                                  style: TextStyles.bold14,
                                ),
                              ),
                            ),
                          ],
                          BlocProvider<LoginCubit>(
                            create: (context) => sl<LoginCubit>(),
                            child: Builder(
                              builder: (context) {
                                return BlocBuilder<LoginCubit, LoginState>(
                                  builder: (context, loginState) {
                                    return Visibility(
                                      visible:
                                          detectUserState
                                              is! DetectUserByPhoneLoading &&
                                          loginState is! LoginLoading,
                                      replacement: const Center(
                                        child: SpinnerLoading(),
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (!_formKey.currentState!
                                              .validate()) {
                                            return;
                                          }

                                          if (detectUserState
                                              is DetectUserByPhoneHasActiveUser) {
                                            context
                                                .read<LoginCubit>()
                                                .loginEvent(
                                                  phone: phoneController.text,
                                                  password:
                                                      passwordController.text,
                                                );
                                          } else {
                                            context
                                                .read<DetectUserByPhoneCubit>()
                                                .detectUserByPhoneEvent(
                                                  phone: phoneController.text,
                                                );
                                          }
                                        },
                                        child: Text(
                                          LocaleKeys.auth_signin.tr(),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          const AppSpacer(heightRatio: 1.5),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       '${LocaleKeys.auth_no_account.tr()} ',
                          //       style: TextStyles.bold14,
                          //     ),
                          //     TextButton(
                          //       style: TextButton.styleFrom(
                          //         padding: EdgeInsets.zero,
                          //       ),
                          //       onPressed: () {
                          //         appNavigator.push(
                          //           screen: const SignUpScreen(),
                          //         );
                          //       },
                          //       child: Text(
                          //         LocaleKeys.auth_create_account.tr(),
                          //         style: TextStyles.bold14,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          GestureDetector(
                            onTap: () {
                              appNavigator.showSheet(
                                child: CallCenterBottomSeet(),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'ليس لديك حساب؟ ',
                                        style: TextStyles.bold16.copyWith(
                                          color: AppColors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'تواصل مع خدمة العملاء',
                                        style: TextStyles.bold16.copyWith(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

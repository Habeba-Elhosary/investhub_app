import 'package:investhub_app/core/constant/values/size_config.dart';
import 'package:investhub_app/core/util/validator.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/password_text_form_field.dart';
import 'package:investhub_app/core/widgets/spinner_loading.dart';
import 'package:investhub_app/features/auth/presentation/cubits/reset_password/reset_password_cubit.dart';
import 'package:investhub_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String? resetToken;
  final String? phone;

  const ResetPasswordScreen({super.key, this.resetToken, this.phone});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: SizeConfig.paddingSymmetric,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AuthHeader(
                    title: LocaleKeys.auth_reset_password.tr(),
                    subtitle: LocaleKeys.auth_password_validation.tr(),
                  ),
                  const AppSpacer(heightRatio: 1.5),
                  PasswordTextFormField(
                    lable: LocaleKeys.auth_password.tr(),
                    validator: (String? value) => Validator.password(value),
                    controller: passwordController,
                  ),
                  const AppSpacer(heightRatio: 1.5),
                  PasswordTextFormField(
                    lable: LocaleKeys.auth_confirm_password.tr(),
                    validator: (String? value) => Validator.confirmPassword(
                      value,
                      passwordController.text,
                    ),
                    controller: confirmPasswordController,
                  ),
                  const AppSpacer(heightRatio: 1.5),
                  BlocProvider(
                    create: (context) => sl<ResetPasswordCubit>(),
                    child: Builder(
                      builder: (context) {
                        return BlocBuilder<
                          ResetPasswordCubit,
                          ResetPasswordState
                        >(
                          builder: (context, state) {
                            return Visibility(
                              visible: state is! ResetPasswordLoading,
                              replacement: const Center(
                                child: SpinnerLoading(),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  print('ResetPasswordScreen: Button pressed');
                                  print(
                                    'ResetPasswordScreen: ResetToken: ${widget.resetToken}',
                                  );
                                  print(
                                    'ResetPasswordScreen: Phone: ${widget.phone}',
                                  );
                                  print(
                                    'ResetPasswordScreen: Password: ${passwordController.text}',
                                  );

                                  if (_formKey.currentState!.validate()) {
                                    if (widget.resetToken != null &&
                                        widget.phone != null) {
                                      print(
                                        'ResetPasswordScreen: Calling resetPasswordEvent',
                                      );
                                      context
                                          .read<ResetPasswordCubit>()
                                          .resetPasswordEvent(
                                            phone: widget.phone!,
                                            password: passwordController.text,
                                            resetToken: widget.resetToken!,
                                          );
                                    } else {
                                      print(
                                        'ResetPasswordScreen: Missing resetToken or phone',
                                      );
                                    }
                                  } else {
                                    print(
                                      'ResetPasswordScreen: Form validation failed',
                                    );
                                  }
                                },
                                child: Text(LocaleKeys.confirm.tr()),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

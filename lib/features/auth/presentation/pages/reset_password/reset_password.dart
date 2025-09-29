import 'package:investhub_app/core/constant/values/size_config.dart';
import 'package:investhub_app/core/util/validator.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/password_text_form_field.dart';
import 'package:investhub_app/core/widgets/spinner_loading.dart';
import 'package:investhub_app/features/auth/domain/usecases/create_new_password_usecase.dart';
import 'package:investhub_app/features/auth/presentation/cubits/create_new_password/create_new_password_cubit.dart';
import 'package:investhub_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

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
                    create: (context) => sl<CreateNewPasswordCubit>(),
                    child: Builder(
                      builder: (context) {
                        return BlocBuilder<
                          CreateNewPasswordCubit,
                          CreateNewPasswordState
                        >(
                          builder: (context, state) {
                            return Visibility(
                              visible: state is! CreateNewPasswordLoading,
                              replacement: const Center(
                                child: SpinnerLoading(),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context
                                        .read<CreateNewPasswordCubit>()
                                        .createNewPasswordEvent(
                                          createNewPasswordParams:
                                              CreateNewPasswordParams(
                                                password:
                                                    passwordController.text,
                                                confirmationPassword:
                                                    confirmPasswordController
                                                        .text,
                                              ),
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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import '../../../../../core/constant/values/size_config.dart';
import '../../../../../core/util/validator.dart';
import '../../../../../core/widgets/app_spacer.dart';
import '../../../../../core/widgets/password_text_form_field.dart';
import '../../../../../core/widgets/spinner_loading.dart';
import '../../../../../injection_container.dart';
import '../../cubits/change_password/change_password_cubit.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _oldPassordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePasswordCubit>(
      create: (BuildContext context) => sl<ChangePasswordCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.profile_change_password.tr()),
          elevation: .2,
        ),
        body: BlocListener<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordSuccess) {
              showSucessToast(state.message);
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
            if (state is ChangePasswordError) {
              showErrorToast(state.message);
            }
          },
          child: SingleChildScrollView(
            padding: SizeConfig.paddingSymmetric,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  PasswordTextFormField(
                    controller: _oldPassordController,
                    lable: LocaleKeys.current_password.tr(),
                  ),
                  const AppSpacer(),
                  PasswordTextFormField(
                    controller: _passwordController,
                    lable: LocaleKeys.new_password.tr(),
                  ),
                  const AppSpacer(),
                  PasswordTextFormField(
                    controller: _passwordConfirmController,
                    validator: (String? value) => Validator.confirmPassword(
                      value,
                      _passwordController.text,
                    ),
                    lable: LocaleKeys.confirm_new_password.tr(),
                  ),
                  const AppSpacer(heightRatio: 2),
                  BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                    builder: (BuildContext context, ChangePasswordState state) {
                      return Visibility(
                        visible: state is! ChangePasswordLoading,
                        replacement: const SpinnerLoading(),
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            context
                                .read<ChangePasswordCubit>()
                                .changePasswordEvent(
                                  oldPassword: _oldPassordController.text,
                                  password: _passwordController.text,
                                  confirmPassword:
                                      _passwordConfirmController.text,
                                );
                          },
                          child: Text(LocaleKeys.confirm.tr()),
                        ),
                      );
                    },
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

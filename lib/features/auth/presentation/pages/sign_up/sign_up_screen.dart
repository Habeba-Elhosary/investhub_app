import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/util/validator.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/password_text_form_field.dart';
import 'package:investhub_app/core/widgets/spinner_loading.dart';
import 'package:investhub_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:investhub_app/features/auth/presentation/cubits/register/register_cubit.dart';
import 'package:investhub_app/features/auth/presentation/pages/sign_in/sign_in_screen.dart';
import 'package:investhub_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AuthHeader(
                    title: LocaleKeys.auth_create_account_message.tr(),
                    subtitle: LocaleKeys.auth_create_account_sub_message.tr(),
                  ),
                  const AppSpacer(heightRatio: 1),
                  TextFormField(
                    controller: nameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) => Validator.name(value),
                    keyboardType: TextInputType.name,
                    onChanged: (String value) {},
                    decoration: InputDecoration(
                      labelText: LocaleKeys.auth_user_name.tr(),
                    ),
                    onTapOutside: (PointerDownEvent event) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const AppSpacer(heightRatio: 1),
                  TextFormField(
                    controller: phoneController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) => Validator.phone(value),
                    keyboardType: TextInputType.phone,
                    onChanged: (String value) {},
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9٠-٩]')),
                      LengthLimitingTextInputFormatter(11),
                    ],
                    cursorColor: AppColors.primary,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.auth_phone_number.tr(),
                    ),
                    onTapOutside: (PointerDownEvent event) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const AppSpacer(heightRatio: 1),
                  PasswordTextFormField(
                    lable: LocaleKeys.auth_password.tr(),
                    controller: passwordController,
                    validator: (String? value) => Validator.password(value),
                  ),
                  const AppSpacer(heightRatio: 1),
                  PasswordTextFormField(
                    lable: LocaleKeys.auth_confirm_password.tr(),
                    controller: confirmPasswordController,
                    validator: (String? value) => Validator.password(value),
                  ),
                  const AppSpacer(heightRatio: 1.2),
                  BlocProvider(
                    create: (context) => sl<RegisterCubit>(),
                    child: Builder(
                      builder: (context) {
                        return BlocBuilder<RegisterCubit, RegisterState>(
                          builder: (context, state) {
                            return Visibility(
                              visible: state is! RegisterLoading,
                              replacement: const Center(
                                child: SpinnerLoading(),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    final registerParams = RegisterParams(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      password: passwordController.text,
                                      confirmPassword:
                                          confirmPasswordController.text,
                                    );
                                    context.read<RegisterCubit>().registerEvent(
                                      registerParams: registerParams,
                                    );
                                  }
                                },
                                child: Text(
                                  LocaleKeys.auth_create_account.tr(),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.auth_do_you_have_account.tr(),
                        style: TextStyles.bold14,
                      ),
                      TextButton(
                        onPressed: () {
                          appNavigator.push(screen: const SignInScreen());
                        },
                        child: Text(
                          LocaleKeys.auth_go_to_signin.tr(),
                          style: TextStyles.bold14,
                        ),
                      ),
                    ],
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

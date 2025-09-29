import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/size_config.dart';
import 'package:investhub_app/core/util/validator.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/spinner_loading.dart';
import 'package:investhub_app/features/auth/presentation/cubits/forget_password/forget_password_cubit.dart';
import 'package:investhub_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<CreateNewPasswordScreen> {
  late TextEditingController phoneController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    phoneController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: SizeConfig.paddingSymmetric,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AuthHeader(
                  title: LocaleKeys.auth_forgot_password.tr(),
                  subtitle: LocaleKeys
                      .auth_enter_your_phone_number_to_reset_password
                      .tr(),
                ),
                const AppSpacer(heightRatio: 1.5),
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
                const AppSpacer(heightRatio: 1.5),
                BlocProvider(
                  create: (context) => sl<ForgetPasswordCubit>(),
                  child: Builder(
                    builder: (context) {
                      return BlocBuilder<
                        ForgetPasswordCubit,
                        ForgetPasswordState
                      >(
                        builder: (context, state) {
                          return Visibility(
                            visible: state is! ForgetPasswordLoading,
                            replacement: const Center(child: SpinnerLoading()),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<ForgetPasswordCubit>()
                                      .forgetPasswordEvent(
                                        phone: phoneController.text,
                                      );
                                }
                              },
                              child: Text(LocaleKeys.send.tr()),
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
    );
  }
}

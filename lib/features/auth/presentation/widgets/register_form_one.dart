import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/util/validator.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/password_text_form_field.dart';
import 'package:investhub_app/features/auth/presentation/cubits/register/register_cubit.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';

class RegisterFormOne extends StatelessWidget {
  final RegisterCubit registerCubit;
  const RegisterFormOne({super.key, required this.registerCubit});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: registerCubit.formKeyStep1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(LocaleKeys.auth_full_name.tr(), style: TextStyles.regular16),
          AppSpacer(heightRatio: 0.5),
          TextFormField(
            controller: registerCubit.nameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onTapOutside: (PointerDownEvent event) =>
                FocusScope.of(context).unfocus(),
            validator: (String? value) => Validator.name(value),
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.person_outline_rounded),
              hintText: LocaleKeys.auth_enter_full_name.tr(),
            ),
          ),
          AppSpacer(heightRatio: 0.7),
          Text(LocaleKeys.auth_email.tr(), style: TextStyles.regular16),
          AppSpacer(heightRatio: 0.5),
          TextFormField(
            controller: registerCubit.emailController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onTapOutside: (PointerDownEvent event) =>
                FocusScope.of(context).unfocus(),
            validator: (String? value) => Validator.email(value),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.email_outlined),
              hintText: 'example@gmail.com',
            ),
          ),
          AppSpacer(heightRatio: 0.7),
          Text(LocaleKeys.auth_phone_number.tr(), style: TextStyles.regular16),
          AppSpacer(heightRatio: 0.5),
          TextFormField(
            controller: registerCubit.phoneController,
            onTapOutside: (PointerDownEvent event) =>
                FocusScope.of(context).unfocus(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) => Validator.phone(value),
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.phone_outlined),
              hintText: '05XXXXXXXX',
            ),
          ),
          AppSpacer(heightRatio: 0.7),
          Text(LocaleKeys.auth_password.tr(), style: TextStyles.regular16),
          AppSpacer(heightRatio: 0.5),
          PasswordTextFormField(
            controller: registerCubit.passwordController,
            hint: LocaleKeys.auth_enter_password.tr(),
            suffixColor: AppColors.greyLight,
          ),
          AppSpacer(heightRatio: 0.7),
          Text(LocaleKeys.auth_national_id.tr(), style: TextStyles.regular16),
          AppSpacer(heightRatio: 0.5),
          TextFormField(
            controller: registerCubit.nationalIdController,
            onTapOutside: (PointerDownEvent event) =>
                FocusScope.of(context).unfocus(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) => Validator.numbers(value),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.contact_emergency_outlined),
              hintText: LocaleKeys.auth_enter_national_id.tr(),
            ),
          ),
          AppSpacer(heightRatio: 0.7),
          Text(LocaleKeys.auth_birth_date.tr(), style: TextStyles.regular16),
          AppSpacer(heightRatio: 0.5),
          TextFormField(
            controller: registerCubit.birthDateController,
            onTapOutside: (PointerDownEvent event) =>
                FocusScope.of(context).unfocus(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) => Validator.defaultValidator(value),
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.calendar_today_outlined),
              hintText: LocaleKeys.auth_select_birth_date.tr(),
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                registerCubit.setBirthDate(
                  DateFormat('yyyy-MM-dd').format(pickedDate),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

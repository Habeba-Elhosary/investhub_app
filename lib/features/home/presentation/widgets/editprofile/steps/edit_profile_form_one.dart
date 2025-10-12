import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/util/validator.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/home/presentation/cubit/edit_profile/edit_profile_cubit.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';

class EditProfileFormOne extends StatelessWidget {
  final EditProfileCubit editProfileCubit;
  const EditProfileFormOne({super.key, required this.editProfileCubit});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: editProfileCubit.formKeyStep1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(LocaleKeys.auth_full_name.tr(), style: TextStyles.regular16),
          AppSpacer(heightRatio: 0.5),
          TextFormField(
            controller: editProfileCubit.nameController,
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
            controller: editProfileCubit.emailController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onTapOutside: (PointerDownEvent event) =>
                FocusScope.of(context).unfocus(),
            validator: (String? value) => Validator.email(value),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.email_outlined),
              hintText: LocaleKeys.email_placeholder.tr(),
            ),
          ),
          AppSpacer(heightRatio: 0.7),
          Text(LocaleKeys.auth_phone_number.tr(), style: TextStyles.regular16),
          AppSpacer(heightRatio: 0.5),
          TextFormField(
            controller: editProfileCubit.phoneController,
            onTapOutside: (PointerDownEvent event) =>
                FocusScope.of(context).unfocus(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) => Validator.phone(value),
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.phone_outlined),
              hintText: LocaleKeys.phone_placeholder.tr(),
            ),
          ),
          AppSpacer(heightRatio: 0.7),
          Text(LocaleKeys.auth_national_id.tr(), style: TextStyles.regular16),
          AppSpacer(heightRatio: 0.5),
          TextFormField(
            controller: editProfileCubit.nationalIdController,
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
            controller: editProfileCubit.birthDateController,
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
                locale: const Locale('en',),
              );
              if (pickedDate != null) {
                editProfileCubit.setBirthDate(
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

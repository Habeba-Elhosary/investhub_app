import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/validator.dart';

class PasswordTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final String? lable;
  const PasswordTextFormField({
    super.key,
    this.validator,
    required this.controller,
    this.lable,
  });

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      validator: (String? value) => widget.validator != null
          ? widget.validator!(value)
          : Validator.password(value),
      onTapOutside: (PointerDownEvent event) {
        FocusScope.of(context).unfocus();
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.lable ?? LocaleKeys.auth_password.tr(),
        suffixIcon: GestureDetector(
          onTap: () => setState(() => isObscure = !isObscure),
          child: Icon(
            isObscure ? Icons.visibility_off_rounded : Icons.visibility_rounded,
            color: AppColors.primary,
            size: 23.sp,
          ),
        ),
      ),
    );
  }
}

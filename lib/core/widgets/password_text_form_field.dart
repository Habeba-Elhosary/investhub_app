import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/validator.dart';

class PasswordTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final String? lable;
  final String? hint;
  final Color? suffixColor;
  const PasswordTextFormField({
    super.key,
    this.validator,
    required this.controller,
    this.lable,
    this.hint,
    this.suffixColor,
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
        hintText: widget.hint,
        labelText: widget.lable,
        suffixIcon: GestureDetector(
          onTap: () => setState(() => isObscure = !isObscure),
          child: Icon(
            isObscure ? Icons.visibility_off_rounded : Icons.visibility_rounded,
            color: widget.suffixColor ?? AppColors.primary,
            size: 23.sp,
          ),
        ),
      ),
    );
  }
}

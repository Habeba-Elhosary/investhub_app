import 'package:flutter/material.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/features/auth/presentation/cubits/register/register_cubit.dart';

class RegisterFormTwo extends StatelessWidget {
  final RegisterCubit registerCubit;
  const RegisterFormTwo({super.key, required this.registerCubit});

  @override
  Widget build(BuildContext context) {
    return Form(
      // key: registerCubit.formKeyStep2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('LocaleKeys.auth_governorate.tr()', style: TextStyles.regular16),
          AppSpacer(heightRatio: 0.7),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "اختر حالتك الاجتماعية",
            ),
            items: const [
              DropdownMenuItem(value: "اعزب", child: Text("أعزب")),
              DropdownMenuItem(value: "متزوج", child: Text("متزوج")),
            ],
            onChanged: (String? value) {},
          ),
          AppSpacer(heightRatio: 0.7),
        ],
      ),
    );
  }
}

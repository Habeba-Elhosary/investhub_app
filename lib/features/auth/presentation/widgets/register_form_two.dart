import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/fonts.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/util/validator.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/auth/presentation/cubits/register/register_cubit.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';

class RegisterFormTwo extends StatefulWidget {
  final RegisterCubit registerCubit;
  const RegisterFormTwo({super.key, required this.registerCubit});

  @override
  State<RegisterFormTwo> createState() => _RegisterFormTwoState();
}

class _RegisterFormTwoState extends State<RegisterFormTwo> {
  String? maritalStatus;
  String? educationLevel;
  String? bank;
  int familyMembers = 1;

  final incomeController = TextEditingController();
  final savingsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.registerCubit.formKeyStep2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            LocaleKeys.auth_marital_status.tr(),
            style: TextStyles.regular16,
          ),
          AppSpacer(heightRatio: 0.5),
          DropdownButtonFormField<String>(
            isDense: true,
            decoration: InputDecoration(
              hintText: LocaleKeys.auth_select_marital_status.tr(),
              alignLabelWithHint: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 0,
              ),
            ),
            style: TextStyles.regular16.copyWith(
              fontFamily: AppFonts.tajawal,
              color: Colors.black,
            ),
            items: const [
              DropdownMenuItem(value: "اعزب", child: Text("أعزب")),
              DropdownMenuItem(value: "متزوج", child: Text("متزوج")),
              DropdownMenuItem(value: "مطلق", child: Text("مطلق")),
              DropdownMenuItem(value: "أرمل", child: Text("أرمل")),
            ],
            onChanged: (String? value) {},
          ),
          AppSpacer(heightRatio: 0.7),
          Text(LocaleKeys.auth_family_number.tr(), style: TextStyles.regular16),
          AppSpacer(heightRatio: 0.5),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (familyMembers > 1) {
                    setState(() {
                      familyMembers--;
                    });
                  } else {
                    showErrorToast('لا يمكن ان يكون عدد الاشخاص اقل من 1');
                  }
                },
                child: Container(
                  height: 55.sp,
                  width: 55.sp,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.unActiveBorderColor),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.remove_rounded, size: 20.sp),
                ),
              ),
              AppSpacer(widthRatio: 0.5),
              Expanded(
                child: Container(
                  height: 55.sp,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text("$familyMembers", style: TextStyles.regular20),
                  ),
                ),
              ),
              AppSpacer(widthRatio: 0.5),
              GestureDetector(
                onTap: () {
                  setState(() {
                    familyMembers++;
                  });
                },
                child: Container(
                  height: 55.sp,
                  width: 55.sp,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.unActiveBorderColor),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.add_rounded, size: 20.sp),
                ),
              ),
            ],
          ),
          AppSpacer(heightRatio: 0.7),
          Text(
            LocaleKeys.auth_education_level.tr(),
            style: TextStyles.regular16,
          ),
          AppSpacer(heightRatio: 0.5),
          DropdownButtonFormField<String>(
            isDense: true,
            decoration: InputDecoration(
              hintText: LocaleKeys.auth_select_education_level.tr(),

              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 0,
              ),
            ),
            style: TextStyles.regular16.copyWith(
              fontFamily: AppFonts.tajawal,
              color: Colors.black,
            ),
            items: const [
              DropdownMenuItem(value: "ابتدائي", child: Text("ابتدائي")),
              DropdownMenuItem(value: "متوسط", child: Text("متوسط")),
              DropdownMenuItem(value: "ثانوي", child: Text("ثانوي")),
              DropdownMenuItem(value: "دبلوم", child: Text("دبلوم")),
              DropdownMenuItem(value: "بكالوريوس", child: Text("بكالوريوس")),
              DropdownMenuItem(value: "ماجستير", child: Text("ماجستير")),
              DropdownMenuItem(value: "دكتوراه", child: Text("دكتوراه")),
            ],
            onChanged: (String? value) {},
          ),
          AppSpacer(heightRatio: 0.7),
          Text(LocaleKeys.auth_yearly_income.tr(), style: TextStyles.regular16),
          AppSpacer(heightRatio: 0.5),
          TextFormField(
            // controller: registerCubit.nationalIdController,
            onTapOutside: (PointerDownEvent event) =>
                FocusScope.of(context).unfocus(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) => Validator.numbers(value),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: EdgeInsets.all(18.sp),
                child: Image.asset(
                  AppAssets.imagesSaudiRiyalSymbol,
                  width: 5.sp,
                  height: 5.sp,
                  fit: BoxFit.scaleDown,
                  color: AppColors.primary,
                ),
              ),
              hintText: LocaleKeys.auth_enter_yearly_income.tr(),
            ),
          ),
          AppSpacer(heightRatio: 0.7),
          Text(LocaleKeys.auth_total_savings.tr(), style: TextStyles.regular16),
          AppSpacer(heightRatio: 0.5),
          TextFormField(
            // controller: registerCubit.nationalIdController,
            onTapOutside: (PointerDownEvent event) =>
                FocusScope.of(context).unfocus(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) => Validator.numbers(value),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: EdgeInsets.all(18.sp),
                child: Image.asset(
                  AppAssets.imagesSaudiRiyalSymbol,
                  width: 5.sp,
                  height: 5.sp,
                  fit: BoxFit.scaleDown,
                  color: AppColors.primary,
                ),
              ),
              hintText: LocaleKeys.auth_enter_total_savings.tr(),
            ),
          ),
          AppSpacer(heightRatio: 0.7),
          Text(LocaleKeys.auth_used_bank.tr(), style: TextStyles.regular16),
          AppSpacer(heightRatio: 0.5),
          DropdownButtonFormField<String>(
            isDense: true,
            decoration: InputDecoration(
              hintText: LocaleKeys.auth_select_bank.tr(),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 0,
              ),
            ),
            style: TextStyles.regular16.copyWith(
              fontFamily: AppFonts.tajawal,
              color: Colors.black,
            ),
            items: const [
              DropdownMenuItem(value: "الراجحي", child: Text("مصرف الراجحي")),
              DropdownMenuItem(
                value: "الاهلي",
                child: Text("البنك الأهلي السعودي"),
              ),
              DropdownMenuItem(value: "الرياض", child: Text("بنك الرياض")),
              DropdownMenuItem(value: "الانماء", child: Text("بنك الإنماء")),
              DropdownMenuItem(value: "الجزيرة", child: Text("بنك الجزيرة")),
              DropdownMenuItem(
                value: "العربي",
                child: Text("البنك العربي الوطني"),
              ),
            ],
            onChanged: (String? value) {},
          ),
        ],
      ),
    );
  }
}

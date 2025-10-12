import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investhub_app/core/constant/values/app_assets.dart';
import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/core/constant/values/fonts.dart';
import 'package:investhub_app/core/constant/values/text_styles.dart';
import 'package:investhub_app/core/enums/educational_status_enum.dart';
import 'package:investhub_app/core/enums/marital_status_enum.dart';
import 'package:investhub_app/core/util/validator.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/single_drop_down_selector.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:investhub_app/features/general/domain/entities/banks_response.dart';
import 'package:investhub_app/features/general/presentation/cubits/get_banks/get_banks_cubit.dart';
import 'package:investhub_app/features/home/presentation/cubit/edit_profile/edit_profile_cubit.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';

class EditProfileFormTwo extends StatefulWidget {
  final EditProfileCubit editProfileCubit;
  const EditProfileFormTwo({super.key, required this.editProfileCubit});

  @override
  State<EditProfileFormTwo> createState() => _EditProfileFormTwoState();
}

class _EditProfileFormTwoState extends State<EditProfileFormTwo> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeBankSelection();
    });
  }

  void _initializeBankSelection() async {
    final banksCubit = context.read<GetBanksCubit>();

    if (banksCubit.banks.isNotEmpty &&
        widget.editProfileCubit.usedBank == null) {
      await _setInitialBank(banksCubit.banks);
    }
  }

  Future<void> _setInitialBank(List<Bank> banks) async {
    try {
      final user = await sl<AuthLocalDataSource>().getCacheUser();
      final userBankName = user.bank;

      final matchingBank = banks.firstWhere(
        (bank) => bank.name == userBankName,
        orElse: () => banks.first,
      );

      widget.editProfileCubit.setBank(matchingBank);
    } catch (e) {
      widget.editProfileCubit.setBank(banks.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.editProfileCubit.formKeyStep2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            LocaleKeys.auth_marital_status.tr(),
            style: TextStyles.regular16,
          ),
          AppSpacer(heightRatio: 0.5),
          DropdownButtonFormField<MaritalStatus>(
            validator: (value) {
              if (value == null) {
                return LocaleKeys.validationMessages_error_filed_required.tr();
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            isDense: true,
            decoration: InputDecoration(
              hintText: LocaleKeys.auth_select_marital_status.tr(),
              alignLabelWithHint: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              filled: true,
              fillColor: Theme.of(context).cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            dropdownColor: Theme.of(context).cardColor,
            style: TextStyles.regular16.copyWith(
              fontFamily: AppFonts.tajawal,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
            value: widget.editProfileCubit.maritalStatus,
            items: MaritalStatus.values.map((status) {
              return DropdownMenuItem<MaritalStatus>(
                value: status,
                child: Text(
                  getMaritalStatusString(status),
                  style: TextStyles.regular16.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              );
            }).toList(),
            onChanged: (MaritalStatus? value) {
              if (value == null) return;
              widget.editProfileCubit.setMaterialStatus(value);
            },
          ),

          AppSpacer(heightRatio: 0.7),
          Text(LocaleKeys.auth_family_number.tr(), style: TextStyles.regular16),
          AppSpacer(heightRatio: 0.5),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  final currentValue = widget.editProfileCubit.familyNumber;
                  if (currentValue > 1) {
                    final newValue = currentValue - 1;
                    widget.editProfileCubit.setFamilyNumber(newValue);
                    setState(() {});
                  } else {
                    showErrorToast(LocaleKeys.more_than_one_person.tr());
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
                    child: Text(
                      "${widget.editProfileCubit.familyNumber}",
                      style: TextStyles.regular20,
                    ),
                  ),
                ),
              ),
              AppSpacer(widthRatio: 0.5),
              GestureDetector(
                onTap: () {
                  final newValue = widget.editProfileCubit.familyNumber + 1;
                  widget.editProfileCubit.setFamilyNumber(newValue);
                  setState(() {});
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
          DropdownButtonFormField<EducationalStatus>(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null) {
                return LocaleKeys.validationMessages_error_filed_required.tr();
              }
              return null;
            },
            isDense: true,
            decoration: InputDecoration(
              hintText: LocaleKeys.auth_select_education_level.tr(),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 0,
              ),
              filled: true,
              fillColor: Theme.of(context).cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            dropdownColor: Theme.of(context).cardColor,
            style: TextStyles.regular16.copyWith(
              fontFamily: AppFonts.tajawal,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
            value: widget.editProfileCubit.educationalLevel,
            items: EducationalStatus.values.map((status) {
              return DropdownMenuItem<EducationalStatus>(
                value: status,
                child: Text(
                  getEducationalStatusString(status),
                  style: TextStyles.regular16.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              );
            }).toList(),
            onChanged: (EducationalStatus? value) {
              if (value == null) return;
              widget.editProfileCubit.setEducationalLevel(value);
            },
          ),
          AppSpacer(heightRatio: 0.7),
          Text(LocaleKeys.auth_yearly_income.tr(), style: TextStyles.regular16),
          AppSpacer(heightRatio: 0.5),
          TextFormField(
            controller: widget.editProfileCubit.annualIncomeController,
            onTapOutside: (PointerDownEvent event) =>
                FocusScope.of(context).unfocus(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) => Validator.numbers(value),
            keyboardType: TextInputType.number,
            style: TextStyles.regular16.copyWith(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.all(18.sp),
                child: Image.asset(
                  AppAssets.imagesSaudiRiyalSymbol,
                  width: 5.sp,
                  height: 5.sp,
                  fit: BoxFit.scaleDown,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              hintText: LocaleKeys.auth_enter_yearly_income.tr(),
              hintStyle: TextStyles.regular16.copyWith(
                color: Theme.of(
                  context,
                ).textTheme.bodyMedium?.color?.withOpacity(0.6),
              ),
            ),
          ),
          AppSpacer(heightRatio: 0.7),
          Text(LocaleKeys.auth_total_savings.tr(), style: TextStyles.regular16),
          AppSpacer(heightRatio: 0.5),
          TextFormField(
            controller: widget.editProfileCubit.totalSavingController,
            onTapOutside: (PointerDownEvent event) =>
                FocusScope.of(context).unfocus(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) => Validator.numbers(value),
            keyboardType: TextInputType.number,
            style: TextStyles.regular16.copyWith(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.all(18.sp),
                child: Image.asset(
                  AppAssets.imagesSaudiRiyalSymbol,
                  width: 5.sp,
                  height: 5.sp,
                  fit: BoxFit.scaleDown,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              hintText: LocaleKeys.auth_enter_total_savings.tr(),
              hintStyle: TextStyles.regular16.copyWith(
                color: Theme.of(
                  context,
                ).textTheme.bodyMedium?.color?.withOpacity(0.6),
              ),
            ),
          ),
          AppSpacer(heightRatio: 0.7),
          Text(LocaleKeys.auth_used_bank.tr(), style: TextStyles.regular16),
          AppSpacer(heightRatio: 0.5),
          BlocListener<GetBanksCubit, GetBanksState>(
            listener: (context, state) {
              if (state is GetBanksSuccess &&
                  widget.editProfileCubit.usedBank == null) {
                _setInitialBank(context.read<GetBanksCubit>().banks);
              }
            },
            child:
                CoreSingleSelectorDropdown<
                  GetBanksCubit,
                  GetBanksState,
                  GetBanksLoading,
                  GetBanksError,
                  Bank
                >(
                  validator: (Bank? value) =>
                      Validator.defaultValidator(value?.name),
                  options: context.watch<GetBanksCubit>().banks,
                  onChanged: (Bank value) {
                    widget.editProfileCubit.setBank(value);
                  },
                  hintText: LocaleKeys.auth_select_bank.tr(),
                  label: '',
                  initState: () {
                    context.read<GetBanksCubit>().getBanksEvent();
                  },
                  initValue: widget.editProfileCubit.usedBank,
                ),
          ),
        ],
      ),
    );
  }
}

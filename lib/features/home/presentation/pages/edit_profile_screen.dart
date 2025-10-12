// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investhub_app/core/widgets/app_spacer.dart';
import 'package:investhub_app/core/widgets/custom_stepper.dart';
import 'package:investhub_app/core/widgets/spinner_loading.dart';
import 'package:investhub_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:investhub_app/features/general/presentation/cubits/get_banks/get_banks_cubit.dart';
import 'package:investhub_app/features/home/presentation/cubit/edit_profile/edit_profile_cubit.dart';
import 'package:investhub_app/features/home/presentation/widgets/editprofile/steps/edit_profile_form_one.dart';
import 'package:investhub_app/features/home/presentation/widgets/editprofile/steps/edit_profile_form_two.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:investhub_app/injection_container.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EditProfileCubit>(
          create: (context) => sl<EditProfileCubit>()..initializeFields(),
        ),
        BlocProvider<GetBanksCubit>(create: (context) => sl<GetBanksCubit>()),
      ],
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: BlocConsumer<EditProfileCubit, EditProfileState>(
            listener: (context, state) {},
            builder: (context, state) {
              final EditProfileCubit editProfileCubit = context
                  .watch<EditProfileCubit>();
              return SingleChildScrollView(
                padding: EdgeInsets.all(16.sp).copyWith(top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AuthHeader(
                      title: LocaleKeys.profile_edit_profile.tr(),
                      subtitle: LocaleKeys.edit_profile_desc.tr(),
                    ),
                    const AppSpacer(heightRatio: 1.5),
                    CustomStepper(
                      currentStep: editProfileCubit.currentStep,
                      steps: [
                        LocaleKeys.auth_personal_info.tr(),
                        LocaleKeys.auth_financial_info.tr(),
                      ],
                    ),
                    AppSpacer(heightRatio: 0.5),
                    buildEditProfileForm(editProfileCubit),
                    AppSpacer(heightRatio: 1),
                    Row(
                      children: [
                        if (editProfileCubit.currentStep > 0)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: editProfileCubit.goToPreviousStep,
                              child: Text(LocaleKeys.the_previous.tr()),
                            ),
                          ),

                        if (editProfileCubit.currentStep > 0)
                          AppSpacer(widthRatio: 0.5),
                        Expanded(
                          child:
                              BlocBuilder<EditProfileCubit, EditProfileState>(
                                buildWhen: (previous, current) =>
                                    current is! EditProfileStepChanged,
                                builder: (context, state) {
                                  return Visibility(
                                    visible: state is! EditProfileLoading,
                                    replacement: const SpinnerLoading(),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (editProfileCubit.currentStep == 0) {
                                          if (editProfileCubit
                                                  .formKeyStep1
                                                  .currentState
                                                  ?.validate() ??
                                              false) {
                                            editProfileCubit.goToNextStep();
                                          }
                                        } else {
                                          editProfileCubit.submit();
                                        }
                                      },
                                      child: Text(
                                        editProfileCubit.currentStep == 0
                                            ? LocaleKeys.the_next.tr()
                                            : LocaleKeys.profile_edit_profile
                                                  .tr(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget buildEditProfileForm(EditProfileCubit editProfileCubit) {
  switch (editProfileCubit.currentStep) {
    case 0:
      return EditProfileFormOne(editProfileCubit: editProfileCubit);
    case 1:
      return EditProfileFormTwo(editProfileCubit: editProfileCubit);
    default:
      return EditProfileFormOne(editProfileCubit: editProfileCubit);
  }
}

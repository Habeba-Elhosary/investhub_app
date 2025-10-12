import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investhub_app/core/enums/educational_status_enum.dart';
import 'package:investhub_app/core/enums/marital_status_enum.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:investhub_app/features/general/domain/entities/banks_response.dart';
import 'package:investhub_app/features/home/domain/entities/edit_profile_params.dart';
import 'package:investhub_app/features/home/domain/entities/form_interface.dart';
import 'package:investhub_app/features/home/domain/usecases/edit_profile_usecase.dart';
import 'package:investhub_app/features/home/presentation/pages/main_screen.dart';
import 'package:investhub_app/injection_container.dart';
part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState>
    implements FormInterface {
  final EditProfileUsecase editProfileUsecase;
  final AuthLocalDataSource localDataSource;

  EditProfileCubit({
    required this.editProfileUsecase,
    required this.localDataSource,
  }) : super(EditProfileInitial());

  // Controllers Step 1
  @override
  final TextEditingController nameController = TextEditingController();
  @override
  final TextEditingController emailController = TextEditingController();
  @override
  final TextEditingController phoneController = TextEditingController();
  @override
  final TextEditingController nationalIdController = TextEditingController();
  @override
  final TextEditingController birthDateController = TextEditingController();

  // Controllers Step 2
  @override
  MaritalStatus? maritalStatus;
  @override
  int familyNumber = 1;
  @override
  EducationalStatus? educationalLevel;
  @override
  final TextEditingController annualIncomeController = TextEditingController();
  @override
  final TextEditingController totalSavingController = TextEditingController();
  @override
  Bank? usedBank;

  @override
  final formKeyStep1 = GlobalKey<FormState>();
  @override
  final formKeyStep2 = GlobalKey<FormState>();
  @override
  final formKeyStep3 = GlobalKey<FormState>();

  @override
  int currentStep = 0;

  @override
  List<Map<String, dynamic>> get answers => [];

  Future<void> initializeFields() async {
    try {
      final User user = await localDataSource.getCacheUser();

      nameController.text = user.name;
      emailController.text = user.email;
      phoneController.text = user.phone;
      nationalIdController.text = user.nationalId;
      birthDateController.text = user.dateOfBirth.toString().split(' ')[0];
      // Initialize Step 2 fields
      maritalStatus = MaritalStatus.values.firstWhere(
        (status) => status.name == user.maritalStatus,
        orElse: () => MaritalStatus.single,
      );
      familyNumber = user.familyMembersCount;
      educationalLevel = EducationalStatus.values.firstWhere(
        (level) => level.name == user.educationLevel,
        orElse: () => EducationalStatus.highSchool,
      );
      annualIncomeController.text = user.annualIncome.toString();
      totalSavingController.text = user.totalSavings.toString();

      // Note: Bank will be initialized when banks are loaded
      // The bank field in User is a String, but we need a Bank object
      // This will be handled in the UI when banks are loaded

      emit(EditProfileInitial());
    } catch (e) {
      log('Error initializing edit profile fields: $e');
      showErrorToast('فشل في تحميل بيانات المستخدم');
    }
  }

  @override
  void setBirthDate(String date) {
    birthDateController.text = date;
    emit(EditProfileInitial());
  }

  @override
  void setMaterialStatus(MaritalStatus status) {
    maritalStatus = status;
    emit(EditProfileInitial());
  }

  @override
  void setEducationalLevel(EducationalStatus level) {
    educationalLevel = level;
    emit(EditProfileInitial());
  }

  @override
  void setBank(Bank bank) {
    usedBank = bank;
    emit(EditProfileInitial());
  }

  @override
  void setFamilyNumber(int number) {
    familyNumber = number;
    emit(EditProfileInitial());
  }

  @override
  void updateAnswer(int questionId, String answer) {
    // Not used in edit profile (no questions step)
    emit(EditProfileInitial());
  }

  void goToNextStep() {
    if (currentStep == 0 && formKeyStep1.currentState!.validate()) {
      currentStep = 1;
      emit(EditProfileStepChanged(currentStep));
    } else {
      submit();
    }
  }

  void goToPreviousStep() {
    if (currentStep > 0) {
      currentStep--;
      emit(EditProfileStepChanged(currentStep));
    }
  }

  Future<void> submit() async {
    final params = EditProfileParams(
      name: nameController.text,
      phone: phoneController.text,
      email: emailController.text,
      nationalId: nationalIdController.text,
      birthDate: birthDateController.text,
      maritalStatus: maritalStatus!,
      familyNum: familyNumber,
      educationalLevel: educationalLevel!,
      annualIncome: num.tryParse(annualIncomeController.text) ?? 0,
      totalSaving: num.tryParse(totalSavingController.text) ?? 0,
      bank: usedBank!,
      answers: [],
    );
    log(params.toJson().toString());
    emit(EditProfileLoading());
    final result = await editProfileUsecase(params);
    result.fold(
      (failure) {
        showErrorToast(failure.message);
        emit(EditProfileFailure(failure.message));
      },
      (AuthResponse authResponse) async {
        await localDataSource.cacheUser(authResponse.data);
        showSucessToast('تم تحديث الملف الشخصي بنجاح');
        appNavigator.pushReplacement(screen: const MainScreen());
        emit(EditProfileSuccess());
      },
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    nationalIdController.dispose();
    birthDateController.dispose();
    annualIncomeController.dispose();
    totalSavingController.dispose();
    return super.close();
  }
}

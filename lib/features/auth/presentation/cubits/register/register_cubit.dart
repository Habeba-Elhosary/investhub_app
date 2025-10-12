import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investhub_app/core/enums/educational_status_enum.dart';
import 'package:investhub_app/core/enums/marital_status_enum.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:investhub_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:investhub_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:investhub_app/features/auth/presentation/pages/verify_otp/verify_otp_screen.dart';
import 'package:investhub_app/features/general/domain/entities/banks_response.dart';
import 'package:investhub_app/features/home/presentation/pages/main_screen.dart';
import 'package:investhub_app/injection_container.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUsecase registerUsecase;
  RegisterCubit({required this.registerUsecase}) : super(RegisterInitial());

  // Controllers Step 1
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  // Controllers Step 2
  MaritalStatus? maritalStatus;
  int familyNumber = 1;
  EducationalStatus? educationalLevel;
  final TextEditingController annualIncomeController = TextEditingController();
  final TextEditingController totalSavingController = TextEditingController();
  Bank? usedBank;

  // Controllers Step 3
  final List<Map<String, dynamic>> answers = [];

  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();
  final formKeyStep3 = GlobalKey<FormState>();

  int currentStep = 0;

  void setBirthDate(String date) {
    birthDateController.text = date;
    emit(RegisterInitial());
  }

  void setMaterialStatus(MaritalStatus status) {
    maritalStatus = status;
    emit(RegisterInitial());
  }

  void setEducationalLevel(EducationalStatus level) {
    educationalLevel = level;
    emit(RegisterInitial());
  }

  void setBank(Bank bank) {
    usedBank = bank;
    emit(RegisterInitial());
  }

  void setFamilyNumber(int number) {
    familyNumber = number;
    emit(RegisterInitial());
  }

  void updateAnswer(int questionId, String answer) {
    final index = answers.indexWhere(
      (item) => item["question_id"] == questionId,
    );
    if (index != -1) {
      answers[index]["answer"] = answer;
    } else {
      answers.add({"question_id": questionId, "answer": answer});
    }
    emit(RegisterInitial());
  }

  void goToNextStep() {
    if (currentStep == 0 && formKeyStep1.currentState!.validate()) {
      currentStep = 1;
      emit(RegisterStepChanged(currentStep));
    } else if (currentStep == 1 && formKeyStep2.currentState!.validate()) {
      currentStep = 2;
      emit(RegisterStepChanged(currentStep));
    } else {
      submit();
    }
  }

  void goToPreviousStep() {
    if (currentStep > 0) {
      currentStep--;
      emit(RegisterStepChanged(currentStep));
    }
  }

  Future<void> submit() async {
    final params = RegisterParams(
      name: nameController.text,
      phone: phoneController.text,
      password: passwordController.text,
      email: emailController.text,
      nationalId: nationalIdController.text,
      birthDate: birthDateController.text,
      maritalStatus: maritalStatus!,
      familyNum: familyNumber,
      educationalLevel: educationalLevel!,
      annualIncome: num.tryParse(annualIncomeController.text) ?? 0,
      totalSaving: num.tryParse(totalSavingController.text) ?? 0,
      bank: usedBank!,
      answers: answers,
    );
    log(params.toJson().toString());
    emit(RegisterLoading());
    final result = await registerUsecase(params);
    result.fold(
      (failure) {
        showErrorToast(failure.message);
        emit(RegisterFailure(failure.message));
      },
      (AuthResponse authResponse) {
        if (authResponse.data.otpVerified == false) {
          appNavigator.pushReplacement(
            screen: const OTPVerficationScreen(isLoginContext: true),
          );
        } else {
          appNavigator.pushReplacement(screen: const MainScreen());
        }
        emit(RegisterSuccess());
      },
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    nationalIdController.dispose();
    passwordController.dispose();
    birthDateController.dispose();
    annualIncomeController.dispose();
    totalSavingController.dispose();
    return super.close();
  }
}

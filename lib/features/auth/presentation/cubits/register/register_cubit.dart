import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investhub_app/core/widgets/toast.dart';
import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:investhub_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:investhub_app/features/auth/domain/usecases/register_usecase.dart';
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
  final TextEditingController regionController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController selectedPositionController =
      TextEditingController();
  final TextEditingController productCategoriesController =
      TextEditingController();

  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();

  int currentStep = 0;

  void setBirthDate(String date) {
    birthDateController.text = date;
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
      confirmPassword: confirmPasswordController.text,
    );

    emit(RegisterLoading());
    final result = await registerUsecase(params);
    result.fold(
      (failure) {
        showErrorToast(failure.message);
        emit(RegisterFailure(failure.message));
      },
      (AuthResponse authResponse) {
        appNavigator.pushReplacement(screen: const MainScreen());
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

    regionController.dispose();
    confirmPasswordController.dispose();
    selectedPositionController.dispose();
    productCategoriesController.dispose();
    return super.close();
  }
}

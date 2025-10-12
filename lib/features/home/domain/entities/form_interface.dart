import 'package:flutter/material.dart';
import 'package:investhub_app/core/enums/educational_status_enum.dart';
import 'package:investhub_app/core/enums/marital_status_enum.dart';
import 'package:investhub_app/features/general/domain/entities/banks_response.dart';

abstract class FormInterface {
  // Controllers Step 1
  TextEditingController get nameController;
  TextEditingController get emailController;
  TextEditingController get phoneController;
  TextEditingController get nationalIdController;
  TextEditingController get birthDateController;

  // Controllers Step 2
  MaritalStatus? get maritalStatus;
  int get familyNumber;
  EducationalStatus? get educationalLevel;
  TextEditingController get annualIncomeController;
  TextEditingController get totalSavingController;
  Bank? get usedBank;

  // Controllers Step 3
  List<Map<String, dynamic>> get answers;

  // Form keys
  GlobalKey<FormState> get formKeyStep1;
  GlobalKey<FormState> get formKeyStep2;
  GlobalKey<FormState> get formKeyStep3;

  // Current step
  int get currentStep;

  // Methods
  void setBirthDate(String date);
  void setMaterialStatus(MaritalStatus status);
  void setEducationalLevel(EducationalStatus level);
  void setBank(Bank bank);
  void setFamilyNumber(int number);
  void updateAnswer(int questionId, String answer);
}

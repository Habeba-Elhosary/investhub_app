// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:investhub_app/core/entities/status_response.dart';
import 'package:investhub_app/core/enums/educational_status_enum.dart';
import 'package:investhub_app/core/enums/marital_status_enum.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:investhub_app/features/auth/data/models/detect_user_response.dart';
import 'package:investhub_app/features/general/domain/entities/banks_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> login({
    required String phone,
    required String password,
  });

  Future<Either<Failure, User>> autoLogin();

  Future<Either<Failure, AuthResponse>> register({
    required RegisterParams params,
  });

  Future<Either<Failure, AuthResponse>> forgetPassword({required String phone});
  Future<Either<Failure, Unit>> createNewPassword({
    required String password,
    required String passwordConfirmation,
  });
  Future<Either<Failure, Unit>> verifyCode(String code);
  Future<Either<Failure, Unit>> sendOTPCode();
  Future<Either<Failure, AuthResponse>> getUserProfile();

  Future<Either<Failure, StatusResponse>> logout();
  Future<Either<Failure, DetectUserResponse>> detectUser(String phone);
}

class RegisterParams {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String nationalId;
  final String birthDate;
  final MaritalStatus maritalStatus;
  final int familyNum;
  final EducationalStatus educationalLevel;
  final num annualIncome;
  final num totalSaving;
  final Bank bank;
  final List<Map<String, dynamic>> answers;

  const RegisterParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.nationalId,
    required this.birthDate,
    required this.maritalStatus,
    required this.familyNum,
    required this.educationalLevel,
    required this.annualIncome,
    required this.totalSaving,
    required this.bank,
    required this.answers,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "password": password,
    "national_id": nationalId,
    "date_of_birth": birthDate,
    "marital_status": maritalStatus.name,
    "family_members_count": familyNum,
    "education_level": educationalLevel.name,
    "annual_income": annualIncome,
    "total_savings": totalSaving,
    "bank_id": bank.id,
    "answers": answers,
  };
}

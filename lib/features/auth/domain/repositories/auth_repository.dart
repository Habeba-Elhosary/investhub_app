import 'package:investhub_app/core/entities/status_response.dart';
import 'package:investhub_app/core/error/failures.dart';
import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:investhub_app/features/auth/data/models/detect_user_response.dart';
import 'package:dartz/dartz.dart';

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
  final String phone;
  final String password;
  final String confirmPassword;

  RegisterParams({
    required this.name,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'password': password,
    'password_confirmation': confirmPassword,
  };
}

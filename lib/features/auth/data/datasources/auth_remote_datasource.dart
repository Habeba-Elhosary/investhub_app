import 'package:investhub_app/core/entities/status_response.dart';
import 'package:investhub_app/core/util/api_base_helper.dart';
import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:investhub_app/features/auth/data/models/detect_user_response.dart';
import 'package:investhub_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

const String loginAPI = '/auth/sign/in';
const String registerAPI = '/auth/sign/up';
const String verfiyCodeAPI = '/otp/verify';

const String userProfileAPI = 'auth/profile';
const String forgetPasswordAPI = '/auth/forget-password';
const String createNewPasswordAPI = '/auth/reset-password';
const String sendOTPCodeAPI = '/auth/resend-otp';
const String logoutAPI = '/auth/logout';
const String detectUserByPhoneAPI = '/auth/detect-user-by-phone';

abstract class AuthRemoteDatasource {
  Future<AuthResponse> login({required String phone, required String password});

  Future<AuthResponse> register({required RegisterParams params});
  Future<AuthResponse> forgetPassword({required String phone});
  Future<Unit> createNewPassword({
    required String password,
    required String passwordConfirmation,
    required String token,
  });
  Future<Unit> verifyCode({
    required String code,
    required String otpToken,
    required String token,
  });
  Future<Unit> sendOTPCode({required String token});
  Future<AuthResponse> getUserProfile(String token);
  Future<StatusResponse> logout({required String token});
  Future<DetectUserResponse> detectUser(String phone);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final ApiBaseHelper apiBaseHelper;

  AuthRemoteDatasourceImpl({required this.apiBaseHelper});

  @override
  Future<AuthResponse> login({
    required String phone,
    required String password,
  }) async {
    try {
      final response = await apiBaseHelper.post(
        url: loginAPI,
        body: <String, dynamic>{'phone': phone, 'password': password},
      );
      return AuthResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthResponse> register({required RegisterParams params}) async {
    try {
      final response = await apiBaseHelper.post(
        url: registerAPI,
        body: {...params.toJson()},
      );
      return AuthResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> createNewPassword({
    required String password,
    required String passwordConfirmation,
    required String token,
  }) async {
    try {
      await apiBaseHelper.post(
        url: createNewPasswordAPI,
        body: <String, dynamic>{
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
        token: token,
      );
      return unit;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthResponse> forgetPassword({required String phone}) async {
    try {
      final dynamic response = await apiBaseHelper.post(
        url: forgetPasswordAPI,
        body: <String, dynamic>{'phone': phone},
      );
      return AuthResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthResponse> getUserProfile(String token) async {
    try {
      final response = await apiBaseHelper.post(
        url: registerAPI,
        token: token,
        body: <String, dynamic>{},
      );
      return AuthResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<StatusResponse> logout({required String token}) async {
    try {
      apiBaseHelper.dio.options.headers.remove('Authorization');
      final response = await apiBaseHelper.post(
        url: logoutAPI,
        token: token,
        body: <String, dynamic>{},
      );
      return StatusResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> sendOTPCode({required String token}) async {
    try {
      await apiBaseHelper.post(
        url: sendOTPCodeAPI,
        token: token,
        body: <String, dynamic>{},
      );
      return unit;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> verifyCode({
    required String code,
    required String otpToken,
    required String token,
  }) async {
    try {
      await apiBaseHelper.post(
        url: verfiyCodeAPI,
        token: token,
        body: <String, dynamic>{'otp': code, 'otp_token': otpToken},
      );
      return unit;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DetectUserResponse> detectUser(String phone) async {
    try {
      final response = await apiBaseHelper.post(
        url: detectUserByPhoneAPI,
        body: <String, dynamic>{'phone': phone},
      );
      return DetectUserResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}

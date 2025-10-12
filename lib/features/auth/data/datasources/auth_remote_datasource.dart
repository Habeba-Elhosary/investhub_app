import 'package:investhub_app/core/entities/status_response.dart';
import 'package:investhub_app/core/error/exceptions.dart';
import 'package:investhub_app/core/util/api_base_helper.dart';
import 'package:investhub_app/features/auth/data/models/auth_response.dart';
import 'package:investhub_app/features/auth/data/models/detect_user_response.dart';
import 'package:investhub_app/features/auth/domain/entities/change_password_params.dart';
import 'package:investhub_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:investhub_app/features/auth/presentation/cubits/google_login/google_login_cubit.dart';

const String loginAPI = '/auth/sign/in';
const String googleLoginAPI = '/auth/social';
const String registerAPI = '/auth/sign/up';
const String verfiyCodeAPI = '/otp/verify';
const String verifyForgetPasswordOTPAPI = '/password/verify-otp';
const String resetPasswordAPI = '/password/reset';

const String userProfileAPI = 'auth/profile';
const String forgetPasswordAPI = '/auth/forgot';
const String createNewPasswordAPI = '/auth/reset-password';
const String sendOTPCodeAPI = '/auth/resend-otp';
const String logoutAPI = '/auth/logout';
const String detectUserByPhoneAPI = '/auth/detect-user-by-phone';
const String changePasswordAPI = '/password/change';

abstract class AuthRemoteDatasource {
  Future<AuthResponse> login({required String phone, required String password});
  Future<AuthResponse> googleLogin({
    required SocialCredentials socialCredentials,
  });

  Future<AuthResponse> register({required RegisterParams params});
  Future<AuthResponse> forgetPassword({required String phone});
  Future<Unit> createNewPassword({
    required String password,
    required String passwordConfirmation,
    required String token,
  });
  Future<String> verifyCode({
    required String code,
    required String otpToken,
    String? token,
  });
  Future<String> verifyForgetPasswordOTP({
    required String phone,
    required String otp,
    required String otpToken,
  });
  Future<String> resetPassword({
    required String phone,
    required String password,
    required String resetToken,
  });
  Future<Unit> sendOTPCode({required String token});
  Future<AuthResponse> getUserProfile(String token);
  Future<StatusResponse> logout({required String token});
  Future<DetectUserResponse> detectUser(String phone);
  Future<String> changePassword({
    required ChangePasswordParams params,
    required String token,
  });
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

      if (response['data'] == null ||
          (response['data'] != null && response["data"]['otp_token'] != null)) {
        throw OtpVerificationRequiredException(
          message: response['message'] ?? 'OTP verification required',
          otpToken: response["data"]['otp_token'],
        );
      }

      return AuthResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthResponse> googleLogin({
    required SocialCredentials socialCredentials,
  }) async {
    try {
      final response = await apiBaseHelper.post(
        url: googleLoginAPI,
        body: socialCredentials.toJson(),
      );

      if (response['data'] == null ||
          (response['data'] != null && response["data"]['otp_token'] != null)) {
        throw OtpVerificationRequiredException(
          message: response['message'] ?? 'OTP verification required',
          otpToken: response["data"]['otp_token'],
        );
      }

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
  Future<String> verifyCode({
    required String code,
    required String otpToken,
    String? token,
  }) async {
    try {
      final response = await apiBaseHelper.post(
        url: verfiyCodeAPI,
        token: token,
        body: <String, dynamic>{'otp': code, 'otp_token': otpToken},
      );
      if (response is Map<String, dynamic>) {
        return response['message']?.toString() ?? 'تم التحقق بنجاح';
      } else {
        return 'تم التحقق بنجاح';
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> verifyForgetPasswordOTP({
    required String phone,
    required String otp,
    required String otpToken,
  }) async {
    try {
      print('AuthRemoteDatasource: verifyForgetPasswordOTP called');
      print(
        'AuthRemoteDatasource: Phone: $phone, OTP: $otp, OTPToken: $otpToken',
      );
      final response = await apiBaseHelper.post(
        url: verifyForgetPasswordOTPAPI,
        body: <String, dynamic>{
          'phone': phone,
          'otp': otp,
          'otp_token': otpToken,
        },
      );
      print('AuthRemoteDatasource: Response received: $response');
      if (response is Map<String, dynamic>) {
        // The reset_token is nested inside the 'data' object
        final data = response['data'];
        if (data is Map<String, dynamic>) {
          final resetToken = data['reset_token']?.toString() ?? '';
          print('AuthRemoteDatasource: ResetToken extracted: $resetToken');
          return resetToken;
        } else {
          print('AuthRemoteDatasource: Data object is not a Map');
          throw ServerException(message: 'Invalid data format');
        }
      } else {
        print('AuthRemoteDatasource: Invalid response format');
        throw ServerException(message: 'Invalid response format');
      }
    } catch (e) {
      print('AuthRemoteDatasource: Exception: $e');
      rethrow;
    }
  }

  @override
  Future<String> resetPassword({
    required String phone,
    required String password,
    required String resetToken,
  }) async {
    try {
      final response = await apiBaseHelper.post(
        url: resetPasswordAPI,
        body: <String, dynamic>{
          'phone': phone,
          'password': password,
          'reset_token': resetToken,
        },
      );
      if (response is Map<String, dynamic>) {
        return response['message']?.toString() ??
            'تم إعادة تعيين كلمة المرور بنجاح';
      } else {
        return 'تم إعادة تعيين كلمة المرور بنجاح';
      }
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

  @override
  Future<String> changePassword({
    required ChangePasswordParams params,
    required String token,
  }) async {
    try {
      final response = await apiBaseHelper.post(
        url: changePasswordAPI,
        token: token,
        body: params.toJson(),
      );
      return response['message'] ?? 'تم تغيير كلمة المرور بنجاح';
    } catch (e) {
      rethrow;
    }
  }
}

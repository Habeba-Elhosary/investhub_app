// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:investhub_app/core/error/exceptions.dart';
import 'package:investhub_app/core/services/cache_service.dart';
import 'package:investhub_app/features/auth/data/models/auth_response.dart';

const String _accessTokenKey = 'ACCESS_TOKEN';
const String _otpTokenKey = 'OTP_TOKEN';
const String _passwordKey = 'PASSWORD';
const String _phoneKey = 'PHONE';
const String USER_DATA_KEY = 'USER_DATA';

abstract class AuthLocalDataSource {
  Future<void> cacheUserAccessToken({required String token});
  Future<void> cacheNewPassword({required String newPassword});
  Future<void> cacheUserCredentials({
    required String phone,
    required String password,
  });
  Future<(String phone, String password)> getUserCredentials();
  Future<void> cacheUserOtpToken({required String token});
  Future<String> getUserAccessToken();
  Future<void> cacheUser(User user);
  Future<User> getCacheUser();
  Future<String> getCacheUserOtpToken();
  Future<String> checkAccessForGuest();
  Future<void> clearData();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final CacheService cacheService;

  AuthLocalDataSourceImpl({required this.cacheService});

  @override
  Future<void> cacheUserAccessToken({required String token}) async {
    try {
      await cacheService.setSecureString(_accessTokenKey, token);
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUserOtpToken({required String token}) async {
    try {
      await cacheService.setSecureString(_otpTokenKey, token);
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<String> getUserAccessToken() async {
    try {
      final String? token = await cacheService.getSecureString(_accessTokenKey);
      if (token != null) return token;
      throw CacheException();
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<String> getCacheUserOtpToken() async {
    try {
      final String? token = await cacheService.getSecureString(_otpTokenKey);
      if (token != null) return token;
      throw CacheException();
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<String> checkAccessForGuest() async {
    try {
      final String? token = await cacheService.getSecureString(_accessTokenKey);
      return token ?? '';
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<void> clearData() async {
    try {
      await cacheService.clear();
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUserCredentials({
    required String phone,
    required String password,
  }) async {
    try {
      await cacheService.setSecureString(_passwordKey, password);
      await cacheService.setSecureString(_phoneKey, phone);
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<(String, String)> getUserCredentials() async {
    try {
      final String? phone = await cacheService.getSecureString(_phoneKey);
      final String? password = await cacheService.getSecureString(_passwordKey);
      if (phone == null || password == null) throw CacheException();
      return (phone, password);
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUser(User user) async {
    try {
      await cacheService.setString(USER_DATA_KEY, user.toRawJson());
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<User> getCacheUser() async {
    try {
      final String? userData = await cacheService.getString(USER_DATA_KEY);
      if (userData == null) {
        throw CacheException();
      } else {
        return User.fromJson(json.decode(userData));
      }
    } catch (error) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNewPassword({required String newPassword}) async {
    try {
      await cacheService.setSecureString(_passwordKey, newPassword);
    } catch (_) {
      throw CacheException();
    }
  }
}

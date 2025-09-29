import 'dart:developer';
import 'package:investhub_app/core/error/exceptions.dart';
import 'package:investhub_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:investhub_app/injection_container.dart';
import 'package:flutter/material.dart';

class TokenStorageHelper {
  static bool _isLoggedIn = false;
  static String? _cachedToken;

  static final AuthLocalDataSource _authLocal = AuthLocalDataSourceImpl(
    cacheService: sl(),
  );

  static bool get isLoggedIn => _isLoggedIn;

  static Future<void> saveToken(String token) async {
    try {
      await _authLocal.cacheUserAccessToken(token: token);
      _cachedToken = token;
      _isLoggedIn = token.isNotEmpty;
      log(
        '[TokenStorageHelper] Token saved successfully. Logged in: $_isLoggedIn',
      );
    } catch (e) {
      log('[TokenStorageHelper] Error saving token: $e');
      _isLoggedIn = false;
      _cachedToken = null;
      throw CacheException();
    }
  }

  static Future<void> saveUser(String phone, String password) async {
    try {
      await _authLocal.cacheUserCredentials(phone: phone, password: password);
      log('[TokenStorageHelper] User credentials saved successfully');
    } catch (e) {
      log('[TokenStorageHelper] Error saving user data: $e');
      throw CacheException();
    }
  }

  static Future<(String, String)> getUser() async {
    try {
      final userData = await _authLocal.getUserCredentials();
      log('[TokenStorageHelper] User credentials retrieved successfully');
      return userData;
    } catch (e) {
      log('[TokenStorageHelper] Error getting user data: $e');
      throw CacheException();
    }
  }

  static Future<String?> getToken() async {
    try {
      if (_cachedToken == null) {
        final token = await _authLocal.checkAccessForGuest();
        _cachedToken = token.isEmpty ? null : token;
        _isLoggedIn = _cachedToken != null;
      }

      log('[TokenStorageHelper] Token retrieved. Logged in: $_isLoggedIn');
      return _cachedToken;
    } catch (e) {
      log('[TokenStorageHelper] Error getting token: $e');
      _isLoggedIn = false;
      _cachedToken = null;
      return null;
    }
  }

  static Future<bool> hasValidToken() async {
    try {
      final token = await getToken();
      final isValid = token != null && token.isNotEmpty;
      _isLoggedIn = isValid;

      log('[TokenStorageHelper] Token validation: $isValid');
      return isValid;
    } catch (e) {
      log('[TokenStorageHelper] Error checking token validity: $e');
      _isLoggedIn = false;
      _cachedToken = null;
      return false;
    }
  }

  static Future<void> clearData() async {
    try {
      // await _authLocal.clearData();
      _isLoggedIn = false;
      _cachedToken = null;
      log('[TokenStorageHelper] All data cleared successfully');
    } catch (e) {
      log('[TokenStorageHelper] Error clearing all data: $e');
      throw CacheException();
    }
  }

  static Future<void> clearToken() async {
    try {
      await clearData();
      log('[TokenStorageHelper] Token cleared successfully');
    } catch (e) {
      log('[TokenStorageHelper] Error clearing token: $e');
      throw CacheException();
    }
  }

  static Future<void> refreshTokenState() async {
    _cachedToken = null;
    await hasValidToken();
  }

  static void debugPrintState() {
    log(
      '[TokenStorageHelper] Current state - Logged in: $_isLoggedIn, Cached token exists: ${_cachedToken != null}',
    );
  }

  static Future<void> executeWithTokenCheck({
    required VoidCallback onLoggedIn,
    required VoidCallback onNotLoggedIn,
  }) async {
    final isValid = await hasValidToken();
    if (isValid) {
      onLoggedIn();
    } else {
      onNotLoggedIn();
    }
  }
}

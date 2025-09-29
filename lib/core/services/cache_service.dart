import 'dart:async';

import 'package:investhub_app/injection_container.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheService {
  // Secure Storage methods
  Future<void> setSecureString(String key, String value);
  Future<String?> getSecureString(String key);
  Future<void> removeSecureString(String key);

  // Shared Preferences methods
  Future<void> setString(String key, String value);
  Future<String?> getString(String key);
  Future<void> setBool(String key, bool value);
  Future<bool?> getBool(String key);
  Future<void> remove(String key);
  Future<void> clear();
}

class CacheServiceImpl implements CacheService {
  final FlutterSecureStorage _secureStorage = sl<FlutterSecureStorage>();
  final SharedPreferences prefs = sl<SharedPreferences>();

  // Secure Storage
  @override
  Future<void> setSecureString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> getSecureString(String key) async {
    return await _secureStorage.read(key: key);
  }

  @override
  Future<void> removeSecureString(String key) async {
    await _secureStorage.delete(key: key);
  }

  // Shared Preferences
  @override
  Future<void> setBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    return prefs.getBool(key);
  }

  @override
  Future<void> setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    return prefs.getString(key);
  }

  @override
  Future<void> remove(String key) async {
    await prefs.remove(key);
  }

  @override
  Future<void> clear() async {
    await _secureStorage.deleteAll();
    await prefs.clear();
  }
}

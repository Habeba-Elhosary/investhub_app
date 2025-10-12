import 'package:shared_preferences/shared_preferences.dart';

class ThemeCacheService {
  static const String _isDarkModeKey = 'is_dark_mode';

  static Future<void> saveThemeMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isDarkModeKey, isDarkMode);
  }

  static Future<bool> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isDarkModeKey) ?? false;
  }

  static Future<void> clearThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isDarkModeKey);
  }
}

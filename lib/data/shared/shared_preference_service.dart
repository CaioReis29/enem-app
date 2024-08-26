
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  final SharedPreferences _sharedPreferences;
  SharedPreferenceService(this._sharedPreferences);

  final String _isDarkModeKey = "is_dark_mode";

  Future<void> saveThemePreference(bool isDark) async {
    _sharedPreferences.setBool(_isDarkModeKey, isDark);
  }

  bool? getThemePreference() {
    return _sharedPreferences.getBool(_isDarkModeKey);
  }
}
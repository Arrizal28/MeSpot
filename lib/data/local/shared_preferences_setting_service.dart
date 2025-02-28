import 'package:mespot/data/model/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesSettingService {
  final SharedPreferences _preferences;

  SharedPreferencesSettingService(this._preferences);

  static const String keyDarkTheme = "MYDARKTHEME";
  static const String keyDailyReminder = "MYDAILY_REMINDER";

  Future<void> saveDarkModeSetting(bool isDarkMode) async {
    try {
      await _preferences.setBool(keyDarkTheme, isDarkMode);
    } catch (e) {
      throw Exception("Failed to save dark mode setting: $e");
    }
  }

  Future<void> saveDailyReminderSetting(bool isDailyReminderEnabled) async {
    try {
      await _preferences.setBool(keyDailyReminder, isDailyReminderEnabled);
    } catch (e) {
      throw Exception("Failed to save daily reminder setting: $e");
    }
  }

  bool getDarkModeSetting() {
    return _preferences.getBool(keyDarkTheme) ?? false;
  }

  bool getDailyReminderSetting() {
    return _preferences.getBool(keyDailyReminder) ?? false;
  }
}

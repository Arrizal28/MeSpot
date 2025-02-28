import 'package:flutter/material.dart';
import 'package:mespot/data/local/shared_preferences_setting_service.dart';

class DarkModeProvider extends ChangeNotifier {
  final SharedPreferencesSettingService _service;

  DarkModeProvider(this._service) {
    _isDarkMode = _service.getDarkModeSetting();
  }

  bool _isDarkMode = true;
  bool get isDarkMode => _isDarkMode;

  String _message = "";
  String get message => _message;

  Future<void> toggleDarkMode(bool value) async {
    try {
      await _service.saveDarkModeSetting(value);
      _isDarkMode = value;
      _message = "Dark mode setting saved";
    } catch (e) {
      _message = "Failed to save dark mode setting";
    }
    notifyListeners();
  }
}

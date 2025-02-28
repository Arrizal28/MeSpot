import 'package:flutter/material.dart';
import 'package:mespot/data/local/shared_preferences_setting_service.dart';
import 'package:mespot/services/local_notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  final SharedPreferencesSettingService _service;
  final LocalNotificationService _notificationService;

  NotificationProvider(this._service, this._notificationService) {
    _isDailyReminderEnabled = _service.getDailyReminderSetting();
  }

  bool _isDailyReminderEnabled = true;
  bool get isDailyReminderEnabled => _isDailyReminderEnabled;

  String _message = "";
  String get message => _message;

  int _notificationId = 0;
  bool? _permission = false;
  bool? get permission => _permission;

  // Future<void> toggleDailyReminder(bool value) async {
  //   try {
  //     await _service.saveDailyReminderSetting(value);
  //     _isDailyReminderEnabled = value;
  //     _message = "Daily reminder setting saved";
  //   } catch (e) {
  //     _message = "Failed to save daily reminder setting";
  //   }
  //   notifyListeners();
  // }

  Future<void> requestPermissions() async {
    _permission = await _notificationService.requestPermissions();
    notifyListeners();
  }

  void showNotification({String? title, String? body}) {
    _notificationId += 1;
    _notificationService.showNotification(
      id: _notificationId,
      title: title ?? "New Notification",
      body: body ?? "This is a new notification with id $_notificationId",
      payload: "This is a payload from notification with id $_notificationId",
    );
  }

  Future<void> toggleDailyReminder(bool value) async {
    try {
      await _service.saveDailyReminderSetting(value);
      _isDailyReminderEnabled = value;
      _message = "Daily reminder setting saved";
    } catch (e) {
      _message = "Failed to save daily reminder setting";
    }
    notifyListeners();
  }

  Future<void> cancelNotification(int id) async {
    await _notificationService.cancelNotification(id);
  }
}

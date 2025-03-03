import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:http/http.dart' as http;

class ReminderProvider extends ChangeNotifier {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev/list";
  static const String _workTask = "daily_reminder";

  late SharedPreferences _local;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isReminderOn = false;
  bool get isReminderOn => _isReminderOn;

  ReminderProvider() {
    _loadReminderStatus();
    _initializeNotifications();
  }

  Future<void> initPrefs() async {
    _local = await SharedPreferences.getInstance();
  }

  Future<void> _loadReminderStatus() async {
    await initPrefs();
    _isReminderOn = _local.getBool('MYDAILY_REMINDER') ?? false;
    notifyListeners();
  }

  Future<void> toggleReminder(bool value) async {
    await initPrefs();
    _isReminderOn = value;
    await _local.setBool('MYDAILY_REMINDER', value);

    if (value) {
      await _scheduleDailyReminder();
    } else {
      await _cancelDailyReminder();
    }

    notifyListeners();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(settings);
  }

  Future<void> _scheduleDailyReminder() async {
    final now = DateTime.now();
    final targetTime = DateTime(now.year, now.month, now.day, 11, 00);
    final initialDelay = targetTime.isBefore(now)
        ? targetTime.add(const Duration(days: 1)).difference(now)
        : targetTime.difference(now);
    await Workmanager().initialize(_callbackDispatcher);
    await Workmanager().registerPeriodicTask(
      _workTask,
      _workTask,
      frequency: const Duration(days: 1),
      initialDelay: initialDelay,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }

  Future<void> _cancelDailyReminder() async {
    await Workmanager().cancelByTag(_workTask);
  }

  static Future<void> sendRestaurantNotification() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List restaurants = data['restaurants'];
        if (restaurants.isNotEmpty) {
          final random = Random();
          final selectedRestaurant =
              restaurants[random.nextInt(restaurants.length)];

          FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
              FlutterLocalNotificationsPlugin();
          const AndroidNotificationDetails androidDetails =
              AndroidNotificationDetails(
            'daily_reminder_channel',
            'Daily Reminder Restaurant',
            importance: Importance.high,
            priority: Priority.high,
          );

          const NotificationDetails details = NotificationDetails(
            android: androidDetails,
          );

          await flutterLocalNotificationsPlugin.show(
            0,
            "Today's recommendation",
            "try eating at ${selectedRestaurant['name']}",
            details,
          );
        }
      }
    } catch (e) {
      return;
    }
  }
}

void _callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == "daily_reminder") {
      await ReminderProvider.sendRestaurantNotification();
    }
    return Future.value(true);
  });
}

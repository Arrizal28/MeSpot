import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

@pragma('vm:entry-point')
void _callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Task received: $task at ${DateTime.now()}");
    if (task == "daily_reminder_periodic") {
      print("callbackdispatcher running");
      await ReminderProvider.sendRestaurantNotification();
    }
    return Future.value(true);
  });
}

class ReminderProvider extends ChangeNotifier {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev/list";
  static const String _oneOffworkTask = "daily_reminder_one_off";
  static const String _periodicWorkTask = "daily_reminder_periodic";
  static const String _WorkTask = "daily_reminder";

  late SharedPreferences _local;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isReminderOn = false;
  bool get isReminderOn => _isReminderOn;

  ReminderProvider() {
    _loadReminderStatus();
    _initializeNotifications();
  }

  Future<void> init() async {
    _local = await SharedPreferences.getInstance();
    await Workmanager().initialize(_callbackDispatcher, isInDebugMode: true);
  }

  Future<void> _loadReminderStatus() async {
    await init();
    _isReminderOn = _local.getBool('MYDAILY_REMINDER') ?? false;
    notifyListeners();
  }

  Future<void> toggleReminder(bool value) async {
    await init();
    _isReminderOn = value;
    await _local.setBool('MYDAILY_REMINDER', value);

    if (value) {
      await _scheduleDailyReminder();
      // await _scheduleOneTimeTestTask();
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

  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  tz.TZDateTime _nextInstanceOfElevenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 11);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> _scheduleDailyReminder() async {
    // final now = DateTime.now();
    // final targetTime = DateTime(now.year, now.month, now.day, 11, 00);
    // final initialDelay = targetTime.isBefore(now)
    //     ? targetTime.add(const Duration(days: 1)).difference(now)
    //     : targetTime.difference(now);

    await configureLocalTimeZone();
    final now = tz.TZDateTime.now(tz.local);
    final scheduledTime = _nextInstanceOfElevenAM();
    final initialDelay = scheduledTime.difference(now);
    print(now.toString());
    print(initialDelay.toString());
    try {
      await Workmanager().registerOneOffTask(
        _oneOffworkTask,
        _periodicWorkTask,
        initialDelay: initialDelay,
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
      );

      await Workmanager().registerPeriodicTask(
        _WorkTask,
        _periodicWorkTask,
        frequency: const Duration(days: 1),
        initialDelay: initialDelay,
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
      );

      print("✅ Periodic task registered successfully!");
    } catch (e) {
      print("❌ Error registering periodic task: $e");
    }
  }

  // Future<void> _scheduleOneTimeTestTask() async {
  //   await configureLocalTimeZone();
  //   final now = tz.TZDateTime.now(tz.local);
  //   final scheduledTime = _nextInstanceOfElevenAM();
  //   final initialDelay = scheduledTime.difference(now);

  //   print("Scheduling reminder with delay: $initialDelay");

  //   try {
  //     await Workmanager().registerOneOffTask(
  //       DateTime.now().millisecondsSinceEpoch.toString(), // Nama task unik
  //       _oneOffworkTask,
  //       initialDelay: initialDelay,
  //       constraints: Constraints(
  //         networkType: NetworkType.connected,
  //       ),
  //     );
  //     print("✅ One-off task registered successfully!");
  //   } catch (e) {
  //     print("❌ Error registering one-off task: $e");
  //   }
  // }

  Future<void> _cancelDailyReminder() async {
    print("workmanager canceled");
    await Workmanager().cancelAll();
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

import 'dart:convert';
import 'dart:math';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:mespot/data/model/restaurant.dart';
import 'package:mespot/data/model/restaurant_list_response.dart';
import 'package:mespot/services/http_service.dart';
import 'package:mespot/services/local_notification_service.dart';
import 'package:mespot/static/my_workmanager.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == MyWorkmanager.oneOff.taskName) {
      int notificationId = 0;

      final httpService = HttpService();
      try {
        notificationId += 1;
        final service = LocalNotificationService();
        final response = await httpService
            .getDataFromUrl("https://restaurant-api.dicoding.dev/list");

        final Map<String, dynamic> jsonData = jsonDecode(response);
        final RestaurantListResponse restaurantResponse =
            RestaurantListResponse.fromJson(jsonData);

        if (!restaurantResponse.error &&
            restaurantResponse.restaurants.isNotEmpty) {
          final randomIndex =
              Random().nextInt(restaurantResponse.restaurants.length);
          final Restaurant randomRestaurant =
              restaurantResponse.restaurants[randomIndex];

          await service.showNotification(
            id: notificationId,
            title: "Rekomendasi Hari Ini!",
            body: "Coba makan di ${randomRestaurant.name}",
            payload: randomRestaurant.id,
          );
        }
      } catch (e) {
        print("Error fetching restaurant data: $e");
      }
    }
    return Future.value(true);
  });
}

class WorkmanagerService {
  final Workmanager _workmanager;

  WorkmanagerService([Workmanager? workmanager])
      : _workmanager = workmanager ??= Workmanager();

  Future<void> init() async {
    await _workmanager.initialize(callbackDispatcher, isInDebugMode: true);
    await AndroidAlarmManager.initialize();
  }

  Future<void> runPeriodicTask() async {
    await _workmanager.cancelAll();
    await _workmanager.registerPeriodicTask(
      MyWorkmanager.periodic.uniqueName,
      MyWorkmanager.periodic.taskName,
      frequency: const Duration(days: 1), // Hanya berjalan sekali sehari
      initialDelay: Duration.zero,
      existingWorkPolicy: ExistingWorkPolicy.replace,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }

  Future<void> scheduleDailyWork() async {
    final now = DateTime.now();
    final DateTime firstRun = DateTime(now.year, now.month, now.day, 11, 0, 0);

    print("Menjadwalkan AlarmManager untuk jam: $firstRun");

    await AndroidAlarmManager.periodic(
      const Duration(days: 1),
      0, // ID unik alarm
      _triggerWorkManager,
      startAt: firstRun,
      exact: true,
      wakeup: true,
    );
  }

  @pragma('vm:entry-point')
  static void _triggerWorkManager() {
    print("AlarmManager berjalan, menjalankan WorkManager...");
    Workmanager().registerOneOffTask(
      MyWorkmanager.oneOff.uniqueName,
      MyWorkmanager.oneOff.taskName,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }

  Future<void> cancelAllTask() async {
    await _workmanager.cancelAll();
  }
}


  // Future<void> runDebugTask() async {
  //   await _workmanager.registerOneOffTask(
  //     MyWorkmanager.oneOff.uniqueName,
  //     MyWorkmanager.oneOff.taskName,
  //     initialDelay: const Duration(minutes: 2), // 🔥 Ulangi setiap 2 menit
  //     constraints: Constraints(
  //       networkType: NetworkType.connected,
  //     ),
  //   );
  // }

  // Future<void> runPeriodicTask() async {
  //   await _workmanager.cancelAll();
  //   await _workmanager.registerPeriodicTask(
  //     MyWorkmanager.periodic.uniqueName,
  //     MyWorkmanager.periodic.taskName,
  //     frequency:
  //         const Duration(days: 1),
  //     initialDelay: Duration.zero,
  //     existingWorkPolicy:
  //         ExistingWorkPolicy.replace,
  //     constraints: Constraints(
  //       networkType: NetworkType.connected,
  //     ),
  //   );
  // }

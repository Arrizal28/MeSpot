import 'package:flutter/material.dart';
import 'package:mespot/provider/local/dark_mode_provider.dart';
import 'package:mespot/provider/local/notification_provider.dart';
import 'package:mespot/services/workmanager_service.dart';
import 'package:provider/provider.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Consumer<DarkModeProvider>(
          builder: (context, darkModeProvider, child) {
            return SwitchListTile(
              title: const Text('Dark Theme'),
              value: darkModeProvider.isDarkMode,
              onChanged: (value) => darkModeProvider.toggleDarkMode(value),
            );
          },
        ),
        Consumer<NotificationProvider>(
          builder: (context, notificationProvider, child) {
            return SwitchListTile(
              title: const Text('Daily Reminder'),
              value: notificationProvider.isDailyReminderEnabled,
              onChanged: (value) async {
                if (value) {
                  // Minta izin notifikasi sebelum mengaktifkan Daily Reminder
                  await _requestPermission();
                }
                notificationProvider.toggleDailyReminder(value);

                if (value) {
                  // _runBackgroundPeriodicTask();
                  _runBackgroundOneOffTask();
                } else {
                  _cancelAllTaskInBackground();
                }
              },
            );
          },
        ),
      ],
    ));
  }

  Future<void> _requestPermission() async {
    context.read<NotificationProvider>().requestPermissions();
  }

  void _runBackgroundPeriodicTask() async {
    context.read<WorkmanagerService>().runPeriodicTask();
  }

  void _runBackgroundOneOffTask() async {
    context.read<WorkmanagerService>().scheduleDailyWork();
  }

  void _cancelAllTaskInBackground() async {
    context.read<WorkmanagerService>().cancelAllTask();
  }
}

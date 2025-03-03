import 'package:flutter/material.dart';
import 'package:mespot/provider/local/dark_mode_provider.dart';
import 'package:mespot/provider/local/reminder_provider.dart';
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
        Consumer<ReminderProvider>(
          builder: (context, reminderProvider, child) {
            return SwitchListTile(
              title: const Text('Daily Reminder'),
              value: reminderProvider.isReminderOn,
              onChanged: (value) async {
                reminderProvider.toggleReminder(value);
              },
            );
          },
        ),
      ],
    ));
  }
}

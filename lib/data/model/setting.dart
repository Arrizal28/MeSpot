class Setting {
  final bool isDarkMode;
  final bool isDailyReminderEnabled;

  Setting({
    required this.isDarkMode,
    required this.isDailyReminderEnabled,
  });

  Map<String, dynamic> toJson() => {
        'isDarkMode': isDarkMode,
        'isDailyReminderEnabled': isDailyReminderEnabled,
      };

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      isDarkMode: json['isDarkMode'] ?? false,
      isDailyReminderEnabled: json['isDailyReminderEnabled'] ?? false,
    );
  }

  Setting copyWith({
    bool? isDarkMode,
    bool? isDailyReminderEnabled,
  }) {
    return Setting(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isDailyReminderEnabled:
          isDailyReminderEnabled ?? this.isDailyReminderEnabled,
    );
  }
}

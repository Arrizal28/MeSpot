import 'package:flutter/material.dart';
import 'package:mespot/style/colors/mespot_colors.dart';
import 'package:mespot/style/typography/mespot_text_styles.dart';

class MespotTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      textTheme: _textTheme,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: MespotColors.green.color,
        surface: Colors.white,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: MespotColors.lightbgColor.color,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: MespotColors.green.color,
          surface: MespotColors.containerDarkBgColor.color,
          brightness: Brightness.dark,
        ),
        textTheme: _textTheme,
        useMaterial3: true,
        scaffoldBackgroundColor: MespotColors.blackbgColor.color);
  }

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: MespotTextStyles.displayLarge,
      displayMedium: MespotTextStyles.displayMedium,
      displaySmall: MespotTextStyles.displaySmall,
      headlineLarge: MespotTextStyles.headlineLarge,
      headlineMedium: MespotTextStyles.headlineMedium,
      headlineSmall: MespotTextStyles.headlineSmall,
      titleLarge: MespotTextStyles.titleLarge,
      titleMedium: MespotTextStyles.titleMedium,
      titleSmall: MespotTextStyles.titleSmall,
      bodyLarge: MespotTextStyles.bodyLargeBold,
      bodyMedium: MespotTextStyles.bodyLargeMedium,
      bodySmall: MespotTextStyles.bodyLargeRegular,
      labelLarge: MespotTextStyles.labelLarge,
      labelMedium: MespotTextStyles.labelMedium,
      labelSmall: MespotTextStyles.labelSmall,
    );
  }
}

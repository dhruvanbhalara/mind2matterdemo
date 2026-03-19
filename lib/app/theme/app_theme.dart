import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        surface: AppColors.surface,
        primary: AppColors.happy,
        onSurface: AppColors.text,
      ),
      scaffoldBackgroundColor: AppColors.surface,
      cardColor: AppColors.card,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.text,
          fontWeight: FontWeight.w800,
          fontSize: 36,
          height: 1.15,
        ),
        headlineSmall: TextStyle(
          color: AppColors.text,
          fontWeight: FontWeight.w700,
          fontSize: 28,
        ),
        titleMedium: TextStyle(
          color: AppColors.text,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        bodyMedium: TextStyle(color: AppColors.mutedText, fontSize: 16),
        bodySmall: TextStyle(color: AppColors.mutedText, fontSize: 14),
        labelLarge: TextStyle(
          color: AppColors.text,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      useMaterial3: true,
    );
  }
}

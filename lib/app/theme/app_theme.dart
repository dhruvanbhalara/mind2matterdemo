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
      ),
      useMaterial3: true,
    );
  }
}

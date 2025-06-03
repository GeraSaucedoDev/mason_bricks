// lib/core/theme/light_theme.dart
import 'package:flutter/material.dart';
import 'package:{{app_name}}/core/theme/app_colors.dart';

class LightTheme {
  static final colorScheme = ColorScheme(
    brightness: Brightness.light,
    // Primary
    primary: AppColors.royalBlue,
    onPrimary: AppColors.white,
    primaryContainer: AppColors.skyBlue,
    onPrimaryContainer: AppColors.navy,

    // Secondary
    secondary: AppColors.mint,
    onSecondary: AppColors.white,
    secondaryContainer: AppColors.emerald,
    onSecondaryContainer: AppColors.white,

    // Surface
    surface: AppColors.white,
    onSurface: AppColors.slate,
    onSurfaceVariant: AppColors.slate,

    // Error
    error: AppColors.coral,
    onError: AppColors.white,
    errorContainer: AppColors.salmon,
    onErrorContainer: AppColors.white,

    surfaceTint: AppColors.royalBlue,
    inverseSurface: AppColors.navy,
    onInverseSurface: AppColors.white,
    inversePrimary: AppColors.skyBlue,
  );

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
          elevation: 0,
        ),
      );
}

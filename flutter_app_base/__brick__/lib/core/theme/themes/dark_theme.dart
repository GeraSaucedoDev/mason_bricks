// lib/core/theme/dark_theme.dart
import 'package:flutter/material.dart';
import 'package:{{app_name}}/core/theme/app_colors.dart';

class DarkTheme {
  static final colorScheme = ColorScheme(
    brightness: Brightness.dark,
    // Primary
    primary: AppColors.skyBlue,
    onPrimary: AppColors.white,
    primaryContainer: AppColors.royalBlue,
    onPrimaryContainer: AppColors.white,

    // Secondary
    secondary: AppColors.emerald,
    onSecondary: AppColors.white,
    secondaryContainer: AppColors.mint,
    onSecondaryContainer: AppColors.white,

    // Surface
    surface: AppColors.navy,
    onSurface: AppColors.white,
    onSurfaceVariant: AppColors.white,

    // Error
    error: AppColors.coral,
    onError: AppColors.white,
    errorContainer: AppColors.salmon,
    onErrorContainer: AppColors.white,

    surfaceTint: AppColors.skyBlue,
    inverseSurface: AppColors.white,
    onInverseSurface: AppColors.navy,
    inversePrimary: AppColors.royalBlue,
  );

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        brightness: Brightness.dark,
        fontFamily: 'poppins',
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
          elevation: 0,
        ),
      );
}

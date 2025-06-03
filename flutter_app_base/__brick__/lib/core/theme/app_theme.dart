import 'package:flutter/material.dart';
import 'package:{{app_name}}/core/theme/themes/dark_theme.dart';
import 'package:{{app_name}}/core/theme/themes/light_theme.dart';

abstract class AppTheme {
  static ThemeData get light => LightTheme.theme;
  static ThemeData get dark => DarkTheme.theme;
}

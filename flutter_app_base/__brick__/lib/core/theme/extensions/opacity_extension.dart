import 'package:flutter/material.dart';

extension ColorOpacityExtension on Color {
  Color withOpacitye(double opacity) {
    return withValues(red: r, green: g, blue: b, alpha: opacity);
  }
}

// tool/generate_icons.dart
import 'dart:io';

void main() {
  final iconFiles = Directory('assets/icons')
      .listSync()
      .whereType<File>()
      .where((file) => file.path.toLowerCase().endsWith('.svg'))
      .map((file) => file.uri.pathSegments.last.replaceAll('.svg', ''))
      .toList()
    ..sort();

  final buffer = StringBuffer();
  buffer.writeln('''
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: constant_identifier_names

/// Available icons in the application.
/// This enum is generated automatically from the SVG files in assets/icons directory.
/// Used by [AppIcon] widget to display SVG icons consistently across the app.
enum AppIconName {''');
  buffer.writeln(iconFiles.join(',\n  '));
  buffer.writeln('}');

  final outputDir = Directory('lib/core/theme/icons');
  outputDir.createSync(recursive: true);
  File('lib/core/theme/icons/app_icons.dart')
      .writeAsStringSync(buffer.toString());
}

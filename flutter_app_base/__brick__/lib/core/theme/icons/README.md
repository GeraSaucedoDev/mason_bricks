# Flutter Icon System

## Structure

```
project/
├── assets/
│   └── icons/          # SVG icon files
│       ├── home.svg
│       ├── menu.svg
│       └── search.svg
├── lib/
│   └── core/
│       └── theme/
│           └── icons/
│               ├── app_icon_name.dart  # Generated enum
│               ├── app_icon.dart       # Widget implementation
│               └── index.dart          # Exports
└── tool/
    └── generate_icons.dart  # Generator script
```

## Setup

1. **Create Directory Structure**

   ```bash
   mkdir -p assets/icons
   mkdir -p lib/core/theme/icons
   mkdir -p tool
   ```

2. **Add Generator Script**
   Create `tool/generate_icons.dart`:

   ```dart
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
     File('lib/core/theme/icons/app_icon_name.dart').writeAsStringSync(buffer.toString());
   }
   ```

3. **Create Widget Implementation**
   Create `lib/core/theme/icons/app_icon.dart`:

   ```dart
   import 'package:flutter/widgets.dart';
   import 'package:flutter_svg/flutter_svg.dart';
   import 'app_icon_name.dart';

   class AppIcon extends StatelessWidget {
     static const String _basePath = 'assets/icons';

     final AppIconName icon;
     final double? size;
     final double? width;
     final double? height;
     final Color? color;
     final BlendMode colorBlendMode;

     const AppIcon(
       this.icon, {
       super.key,
       this.size,
       this.width,
       this.height,
       this.color,
       this.colorBlendMode = BlendMode.srcIn,
     });

     @override
     Widget build(BuildContext context) {
       return SvgPicture.asset(
         '$_basePath/${icon.name}.svg',
         width: width ?? size,
         height: height ?? size,
         colorFilter: color != null ? ColorFilter.mode(color, colorBlendMode) : null,
       );
     }
   }
   ```

4. **Create Index File**
   Create `lib/core/theme/icons/index.dart`:

   ```dart
   export 'app_icon.dart';
   export 'app_icon_name.dart';
   ```

5. **Update pubspec.yaml**

   ```yaml
   dependencies:
     flutter_svg: ^latest_version

   flutter:
     assets:
       - assets/icons/
   ```

## Usage

1. **Add SVG Icons**
   Place your SVG files in `assets/icons/` directory.

2. **Generate Enum**
   Run the generator:

   ```bash
   dart run tool/generate_icons.dart
   ```

3. **Use in Code**

   ```dart
   import 'package:your_app/core/theme/icons/index.dart';

   // Basic usage
   AppIcon(AppIconName.menu)

   // With size
   AppIcon(
     AppIconName.home,
     size: 24,
   )

   // With color
   AppIcon(
     AppIconName.search,
     size: 24,
     color: Colors.blue,
   )

   // In IconButton
   IconButton(
     icon: AppIcon(AppIconName.menu),
     onPressed: () {},
   )

   // Custom dimensions
   AppIcon(
     AppIconName.cloud,
     width: 32,
     height: 24,
   )
   ```

## Maintenance

- To add new icons:

  1. Add SVG file to `assets/icons/`
  2. Run generator
  3. Icons are automatically available via `AppIconName` enum

- To update existing icons:

  1. Replace SVG file in `assets/icons/`
  2. No need to run generator unless filename changes

- To remove icons:
  1. Delete SVG file from `assets/icons/`
  2. Run generator
  3. Icon will be removed from `AppIconName` enum

## Best Practices

1. Use meaningful and consistent icon names
2. Keep SVG files optimized and clean
3. Run generator after any changes to icons
4. Use the index.dart for imports
5. Default to using `size` parameter unless specific width/height needed

# Theme System

This document explains how the theme system works, including color management and additional colors outside the theme.

## Directory Structure

```
lib/core/theme/
├── extensions/
│   ├── colors_extension.dart    # Extensions for additional colors
│   └── theme_extension.dart     # Extensions for theme colors
├── themes/
│   ├── dark_theme.dart         # Dark theme configuration
│   └── light_theme.dart        # Light theme configuration
├── app_colors.dart            # Base color definitions
└── app_theme.dart            # Theme configuration
```

## Color System Overview

The color system is organized in three layers of abstraction:

1. **Theme Colors** (Primary usage)

   - Access via `context.colorScheme`
   - Used for most UI elements
   - Automatically handles light/dark modes

2. **Additional Colors** (Secondary usage)

   - Access via `context.colors`
   - For colors needed in the app but not part of the theme
   - Includes light/dark variants

3. **Base Colors** (Avoid direct usage)
   - Defined in `app_colors.dart`
   - Should rarely be used directly
   - Serves as the source for theme and additional colors

## Extensions

### Theme Colors Extension

```dart
// lib/core/theme/extensions/theme_extension.dart
import 'package:flutter/material.dart';

extension ThemeColorsX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
}
```

### Additional Colors Extension

```dart
// lib/core/theme/extensions/colors_extension.dart
import 'package:flutter/material.dart';
import '../app_colors.dart';

extension ColorsExtension on BuildContext {
  ColorDataExtension get colors => ColorDataExtension(this);
}
```

## Usage Examples

### Theme Colors (Preferred)

```dart
import 'package:your_app/core/theme/extensions/theme_extension.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.surface,
      child: Text(
        'Hello',
        style: TextStyle(color: context.colorScheme.onSurface),
      ),
    );
  }
}
```

### Additional Colors

```dart
import 'package:your_app/core/theme/extensions/colors_extension.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.container01,
      child: Text('Special content'),
    );
  }
}
```

## Adding New Colors

### Adding to Theme System

```dart
// lib/core/theme/themes/light_theme.dart or dark_theme.dart
import 'package:flutter/material.dart';
import '../app_colors.dart';

class LightTheme {
  static final colorScheme = ColorScheme(
    // Add to appropriate color role
  );
}
```

### Adding Additional Colors

```dart
// 1. First add to lib/core/theme/app_colors.dart
abstract class AppColors {
  static const newColorLight = Color(0xFF...);
  static const newColorDark = Color(0xFF...);
}

// 2. Then add to lib/core/theme/extensions/colors_extension.dart
class ColorDataExtension {
  final BuildContext context;

  ColorDataExtension(this.context);

  Color get newColor {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.newColorDark
        : AppColors.newColorLight;
  }
}
```

## Best Practices

1. **Theme First Approach**

```dart
import 'package:your_app/core/theme/extensions/theme_extension.dart';

// ✅ Good: Using theme colors
Text(
  'Hello',
  style: TextStyle(color: context.colorScheme.primary),
)

// ❌ Bad: Direct usage of AppColors
Text(
  'Hello',
  style: TextStyle(color: AppColors.royalBlue),
)
```

2. **Additional Colors When Needed**

```dart
import 'package:your_app/core/theme/extensions/colors_extension.dart';

// ✅ Good: Using additional colors through extension
Container(
  color: context.colors.container01,
)

// ❌ Bad: Direct color usage
Container(
  color: AppColors.container01Light,
)
```

## Configuration in MaterialApp

```dart
import 'package:your_app/core/theme/app_theme.dart';

MaterialApp(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  // Optional: force a specific theme
  // themeMode: ThemeMode.system, // .light or .dark
)
```

# Responsive Design Guide

This project implements responsive design using [responsive_sizer 3.3.1](https://pub.dev/packages/responsive_sizer/versions/3.3.1). This guide explains how to use the responsive units throughout the project.

## Responsive Units in Our Project

### Width (.w)

We use `.w` for proportional widths across the app:

```dart
// A card taking half the screen width
Card(
  width: 50.w,  // Always 50% of screen width
)
```

### Height (.h)

Height percentages are used for specific layout needs:

```dart
// Header height
Container(
  height: 10.h,  // Consistent 10% of screen height
)
```

### Density Pixels (.dp)

Our standard unit for consistent sizing across devices:

```dart
// Standard text and spacing in our app
Text(
  'Content',
  style: TextStyle(fontSize: 16.dp),  // Our standard body text size
)
```

### Layout Guidelines

When creating new screens:

1. **Container Widths**:

   ```dart
   Container(
     width: 90.w,  // Standard container width
     padding: EdgeInsets.all(16.dp),  // Standard padding
   )
   ```

2. **List Items**:

   ```dart
   ListTile(
     contentPadding: EdgeInsets.symmetric(
       horizontal: 16.dp,
       vertical: 8.dp,
     ),
   )
   ```

3. **Buttons**:
   ```dart
   ElevatedButton(
     padding: EdgeInsets.symmetric(
       horizontal: 16.dp,
       vertical: 8.dp,
     ),
     child: Text(
       'Button',
       style: TextStyle(fontSize: 16.dp),
     ),
   )
   ```

## Common Patterns

### Cards

```dart
Card(
  margin: EdgeInsets.all(16.dp),
  child: Container(
    width: 90.w,
    padding: EdgeInsets.all(16.dp),
    child: Text(
      'Card Content',
      style: TextStyle(fontSize: 16.dp),
    ),
  ),
)
```

### Form Fields

```dart
TextFormField(
  style: TextStyle(fontSize: 16.dp),
  decoration: InputDecoration(
    contentPadding: EdgeInsets.all(16.dp),
    labelStyle: TextStyle(fontSize: 14.dp),
  ),
)
```

## Device-Specific Adjustments

When needed, use Device.screenType for specific adjustments:

```dart
Container(
  padding: Device.screenType == ScreenType.mobile
    ? EdgeInsets.all(16.dp)
    : EdgeInsets.all(24.dp),
)
```

## Tips for Maintaining Consistency

1. Always use `.dp` for text sizes and spacing
2. Use `.w` for width-based layouts
3. Use `.h` sparingly, mainly for fixed-height components
4. Test layouts on both mobile and tablet views

# Flutter Text Styles System

## File Structure

```
lib/
├── theme/
│   ├── extensions/
│   │   ├── colors_extensions.dart
│   │   ├── textstyles_extension.dart
│   │   └── theme_extensions.dart
│   └── fonts/
│       ├── poppins.dart
│       └── roboto.dart
```

## Overview

A simple and flexible system to handle text styles in Flutter using BuildContext extensions.

Recomended use clamps to handle better font sizes

## Main Components

### textstyles_extension.dart

```dart
extension TextStyleExtension on BuildContext {
  TextStyles get textstyles => TextStyles();
}

class TextStyles {
  final roboto = Roboto.instance;
  // final poppins = Poppins.instance; // as example When needed
}
```

### fonts/roboto.dart

Defines text styles for Roboto font (Material's default font).

```dart
class Roboto {
  static final instance = Roboto._();
  Roboto._();

  final TextStyle h1Black = const TextStyle(
    fontFamily: 'Roboto',
    fontSize: 32,
    fontWeight: FontWeight.w900,
  );
  // ... more styles
}
```

### fonts/poppins.dart

Template for adding Poppins font (or any other).

```dart
class Poppins {
  static final instance = Poppins._();
  Poppins._();

  final TextStyle h1Black = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 32,
    fontWeight: FontWeight.w900,
  );
  // ... more styles
}
```

## Usage

### Basic Access

```dart
Text('Title', style: context.textstyles.roboto.h1Black)
```

### Available Styles

Each font provides these styles by default:

- `h1Black`: Size 32, weight 900
- `h1Medium`: Size 32, weight 500
- `h3Medium`: Size 24, weight 500

Note: You can add as many custom styles as needed. While the naming convention is flexible (e.g., `titleBold`, `bodyRegular`, `captionLight`), it's recommended to maintain consistency across your project. Some suggested patterns:

- Size + Weight: `h1Black`, `h2Medium`, `h3Light`
- Purpose + Weight: `titleBold`, `subtitleMedium`, `bodyRegular`
- Semantic + Weight: `primaryBold`, `secondaryMedium`, `accentLight`

## Adding a New Font

1. Create a new file in `theme/fonts/` (e.g., `new_font.dart`)
2. Implement the class following the singleton pattern:

```dart
class NewFont {
  static final instance = NewFont._();
  NewFont._();

  // Define styles...
}
```

3. Add the instance in `TextStyles`:

```dart
class TextStyles {
  final roboto = Roboto.instance;
  final newFont = NewFont.instance;
}
```

## pubspec.yaml Configuration

For custom fonts, add to `pubspec.yaml`:

```yaml
flutter:
  fonts:
    - family: FontName
      fonts:
        - asset: assets/fonts/Font-Black.ttf
          weight: 900
        - asset: assets/fonts/Font-Medium.ttf
          weight: 500
```

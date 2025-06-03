# Internationalization (l10n)

This project uses Flutter's built-in internationalization support with ARB files.

## Initial Setup

When cloning the repository for the first time:

1. Install dependencies:

```bash
flutter pub get
```

2. Generate localization files:

```bash
flutter gen-l10n
```

This will generate the necessary Dart files in `lib/core/localization/generated/`.

## Project Structure

```
lib/core/localization/
├── l10n/                # Translation files
│   ├── app_en.arb      # English translations
│   └── app_es.arb      # Spanish translations
├── generated/          # Auto-generated files
├── extensions/         # Localization extensions
└── ...
```

## Usage in Code

Use the extension method for easy access to translations:

```dart
import 'package:your_app/core/localization/extensions/localization_extension.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(context.l10n.someText);
  }
}
```

## Adding a New Language

1. Create a new ARB file in `lib/core/localization/l10n/` following the naming convention:

```bash
app_<language_code>.arb
```

For example, for French:

```bash
app_fr.arb
```

2. Copy the content structure from `app_en.arb` and translate the values:

```json
{
  "@@locale": "fr",
  "appTitle": "Nom de l'application",
  "welcomeMessage": "Bienvenue",
  "save": "Enregistrer",
  "cancel": "Annuler"
}
```

3. Add the new locale to supported locales in your app:

```dart
supportedLocales: const [
  Locale('en'),
  Locale('es'),
  Locale('fr'),  // Add new locale here
],
```

4. Regenerate the localization files:

```bash
flutter gen-l10n
```

## Language Resolution

The app will:

1. First try to use the device's language if supported
2. If not supported, fall back to Spanish (es)

This is configured in the MaterialApp:

```dart
localeResolutionCallback: (locale, supportedLocales) {
  if (locale != null) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return locale;
      }
    }
  }
  return const Locale('es');
},
```

## Modifying Existing Translations

1. Locate the appropriate ARB file in `lib/core/localization/l10n/`
2. Update the translation value
3. Run `flutter gen-l10n` to regenerate files
4. Test the changes in the app

## Best Practices

1. Keep keys descriptive and organized
2. Always provide translations for all supported languages
3. Test the app in all supported languages
4. Run `flutter gen-l10n` after any changes to ARB files

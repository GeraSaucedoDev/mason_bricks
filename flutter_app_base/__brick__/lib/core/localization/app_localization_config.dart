import 'package:flutter/material.dart';
import 'package:{{app_name}}/core/localization/generated/app_localizations.dart';

// Make sure localization generated files was generated correctly to use this class
class AppLocalizationsConfig {
  static Iterable<LocalizationsDelegate<dynamic>>? get localizationsDelegates {
    return AppLocalizations.localizationsDelegates;
  }

  static Iterable<Locale> get supportedLocales {
    return AppLocalizations.supportedLocales;
  }

  static Locale? Function(Locale?, Iterable<Locale>)? get localeResolution {
    return (locale, supportedLocales) {
      // if device locale is supported, use it
      if (locale != null) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return locale;
          }
        }
      }
      // if not, english locale is used by default
      return const Locale('en');
    };
  }
}

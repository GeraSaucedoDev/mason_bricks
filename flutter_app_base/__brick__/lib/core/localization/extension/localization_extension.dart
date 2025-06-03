import 'package:flutter/material.dart';
import 'package:{{app_name}}/core/localization/generated/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

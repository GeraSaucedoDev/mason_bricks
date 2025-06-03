import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:{{app_name}}/core/localization/extension/localization_extension.dart';

enum EmailValidationError { empty, format }

class EmailInput extends FormzInput<String, EmailValidationError> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty([super.value = '']) : super.dirty();

  static final _regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  EmailValidationError? validator(String value) {
    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) return EmailValidationError.empty;
    return _regex.hasMatch(trimmedValue) ? null : EmailValidationError.format;
  }

  String? errorMessage(BuildContext context) {
    if (isValid) return null;

    if (displayError == EmailValidationError.empty || isPure) {
      return context.l10n.inputEmailErrorEmpty;
    }

    switch (displayError) {
      case EmailValidationError.empty:
        return context.l10n.inputEmailErrorEmpty;
      case EmailValidationError.format:
        return context.l10n.inputEmailErrorFormat;
      default:
        return null;
    }
  }
}

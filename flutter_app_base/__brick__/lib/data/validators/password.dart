import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:{{app_name}}/core/localization/extension/localization_extension.dart';

enum PasswordValidationError { empty, length, uppercase, number, symbol }

class PasswordInput extends FormzInput<String, PasswordValidationError> {
  final bool onlyEmptyValidation;

  const PasswordInput.pure({this.onlyEmptyValidation = false}) : super.pure('');
  const PasswordInput.dirty(super.value, {this.onlyEmptyValidation = false})
      : super.dirty();

  String? errorMessage(BuildContext context) {
    if (isValid) return null;

    if (displayError == PasswordValidationError.empty || isPure) {
      return context.l10n.inputPasswordErrorEmpty;
    }

    if (onlyEmptyValidation) return null;

    switch (displayError) {
      case PasswordValidationError.length:
        return context.l10n.inputPasswordErrorLength;
      case PasswordValidationError.number:
        return context.l10n.inputPasswordErrorNumber;
      case PasswordValidationError.uppercase:
        return context.l10n.inputPasswordErrorUppercase;
      case PasswordValidationError.symbol:
        return context.l10n.inputPasswordErrorSymbol;
      default:
        return null;
    }
  }

  @override
  PasswordValidationError? validator(String value) {
    if (value.trim().isEmpty) return PasswordValidationError.empty;
    if (onlyEmptyValidation) return null;

    if (value.length < 8) {
      return PasswordValidationError.length;
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return PasswordValidationError.number;
    }

    if (!RegExp(r'[A-ZÁ-ÚÑ]').hasMatch(value)) {
      return PasswordValidationError.uppercase;
    }

    if (!RegExp(r'^(?=.*[$\[\]{}()?!\-@#%&/\\,><;|_~^=+\.])').hasMatch(value)) {
      return PasswordValidationError.symbol;
    }

    return null;
  }
}

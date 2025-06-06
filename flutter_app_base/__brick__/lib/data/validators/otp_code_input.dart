import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';
import 'package:{{app_name}}/core/localization/extension/localization_extension.dart';

enum OtpCodeValidationError { empty, length }

class OtpCodeInput extends FormzInput<String, OtpCodeValidationError> {
  const OtpCodeInput.pure() : super.pure('');
  const OtpCodeInput.dirty([super.value = '']) : super.dirty();

  String? errorMessage(BuildContext context) {
    if (isValid) return null;

    if (isPure || displayError == OtpCodeValidationError.empty) {
      return context.l10n.inputOtpErrorEmpty;
    }

    if (displayError == OtpCodeValidationError.length) {
      return context.l10n.inputOtpErrorLength;
    }

    return null;
  }

  @override
  OtpCodeValidationError? validator(String value) {
    if (value.trim().isEmpty) {
      return OtpCodeValidationError.empty;
    }

    if (value.length != 6) {
      return OtpCodeValidationError.length;
    }

    return null;
  }
}

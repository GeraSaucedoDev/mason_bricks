import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

enum OtpCodeValidationError { empty, length }

class OtpCodeInput extends FormzInput<String, OtpCodeValidationError> {
  const OtpCodeInput.pure() : super.pure('');
  const OtpCodeInput.dirty([super.value = '']) : super.dirty();

  String? errorMessage(BuildContext context) {
    if (isValid) return null;

    if (isPure || displayError == OtpCodeValidationError.empty) {
      // TODO UPDATE THIS
      return 'input_otp_code_error_empty';
    }

    if (displayError == OtpCodeValidationError.length) {
      // TODO UPDATE THIS MAGIC STRIN
      return 'input_otp_code_error_length';
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

import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:{{app_name}}/core/localization/extension/localization_extension.dart';

enum ConfirmedPasswordError {
  empty,
  mismatch,
}

class ConfirmedPasswordInput
    extends FormzInput<String, ConfirmedPasswordError> {
  final String password;

  const ConfirmedPasswordInput.pure({this.password = ''}) : super.pure('');

  const ConfirmedPasswordInput.dirty({
    required this.password,
    String value = '',
  }) : super.dirty(value);

  ConfirmedPasswordInput copyWith({
    String? password,
    String? value,
  }) {
    return ConfirmedPasswordInput.dirty(
      password: password ?? this.password,
      value: value ?? this.value,
    );
  }

  String? errorMessage(BuildContext context) {
    if (isValid) return null;

    if (isPure || displayError == ConfirmedPasswordError.empty) {
      return context.l10n.inputPasswordErrorEmpty;
    }

    if (displayError == ConfirmedPasswordError.mismatch) {
      //return context.l10n.inputEmailErrorFormat;
      return 'No coinciden las contrasenas';
    }

    return null;
  }

  @override
  ConfirmedPasswordError? validator(String value) {
    if (value.isEmpty) return ConfirmedPasswordError.empty;
    if (password != value) return ConfirmedPasswordError.mismatch;

    return null;
  }
}

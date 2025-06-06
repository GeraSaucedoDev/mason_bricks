import 'package:flutter/material.dart';
import 'package:{{app_name}}/core/localization/extension/localization_extension.dart';
import 'package:{{app_name}}/core/theme/extensions/theme_extensions.dart'
    as color;

class EmailTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Function(String)? onChanged;
  final bool enabled;
  final String? errorText;
  final bool showErrors;

  const EmailTextField({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.enabled = true,
    this.errorText,
    this.showErrors = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      enabled: enabled,
      autocorrect: false,
      maxLength: 100,
      style: TextStyle(
        color: context.colorScheme.onPrimaryContainer,
      ),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: hintText ?? context.l10n.username,
        hintStyle: TextStyle(
          color: context.colorScheme.onPrimaryContainer,
        ),
        errorText: showErrors ? errorText : null,
        counterText: '',
        filled: true,
        fillColor: context.colorScheme.surface,
      ),
    );
  }
}

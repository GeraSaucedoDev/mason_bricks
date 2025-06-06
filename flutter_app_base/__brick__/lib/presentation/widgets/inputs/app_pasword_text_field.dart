import 'package:flutter/material.dart';
import 'package:{{app_name}}/core/theme/extensions/theme_extensions.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Function(String)? onChanged;
  final bool enabled;
  final String? errorText;
  final bool showErrors;

  const PasswordTextField({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.enabled = true,
    this.errorText,
    this.showErrors = false,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      enabled: widget.enabled,
      obscureText: _obscureText,
      maxLength: 40,
      style: TextStyle(
        color: context.colorScheme.onPrimaryContainer,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText ?? 'Contraseña',
        hintStyle: TextStyle(
          color: context.colorScheme.onPrimaryContainer,
        ),
        errorText: widget.showErrors ? widget.errorText : null,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: context.colorScheme.onSurface,
          ),
          onPressed: () => setState(() => _obscureText = !_obscureText),
        ),
        counterText: '',
        filled: true,
        fillColor: context.colorScheme.surface,
      ),
    );
  }
}

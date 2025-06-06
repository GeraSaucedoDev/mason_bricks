import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:{{app_name}}/core/theme/extensions/theme_extensions.dart';

class SixDigitCodeInput extends StatefulWidget {
  final Function(String)? onChanged;
  final bool enabled;
  final String? errorText;
  final bool showErrors;
  final String placeholder;

  const SixDigitCodeInput({
    super.key,
    this.onChanged,
    this.enabled = true,
    this.errorText,
    this.showErrors = false,
    this.placeholder = '*',
  });

  @override
  State<SixDigitCodeInput> createState() => _SixDigitCodeInputState();
}

class _SixDigitCodeInputState extends State<SixDigitCodeInput> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<FocusNode> _keyboardFocusNodes =
      List.generate(6, (_) => FocusNode());

  int? _lastDeletedIndex;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 6; i++) {
      _controllers[i].addListener(() => _onInputChanged());
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) {
          _controllers[i].selection =
              TextSelection.collapsed(offset: _controllers[i].text.length);
        }
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    for (final f in _keyboardFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onInputChanged() {
    final code = _controllers.map((e) => e.text).join();
    widget.onChanged?.call(code);
  }

  void _handleBackspace(int index) {
    if (_controllers[index].text.isEmpty && index > 0) {
      _lastDeletedIndex = index - 1;
      _focusNodes[_lastDeletedIndex!].requestFocus();
      _controllers[_lastDeletedIndex!].selection = TextSelection.collapsed(
        offset: _controllers[_lastDeletedIndex!].text.length,
      );
    }
  }

  void _handlePaste(String pastedText, int startIndex) {
    final digits = pastedText.replaceAll(RegExp(r'[^0-9]'), '').split('');

    for (int i = 0; i < digits.length && startIndex + i < 6; i++) {
      _controllers[startIndex + i].text = digits[i];
    }

    final nextIndex = (startIndex + digits.length).clamp(0, 5);
    _focusNodes[nextIndex].requestFocus();
    _onInputChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(6, (i) {
            return SizedBox(
              width: 45,
              height: 45,
              child: KeyboardListener(
                focusNode: _keyboardFocusNodes[i],
                onKeyEvent: (event) {
                  if (event is KeyDownEvent &&
                      event.logicalKey == LogicalKeyboardKey.backspace &&
                      _controllers[i].text.isEmpty) {
                    _handleBackspace(i);
                  }
                },
                child: TextField(
                  controller: _controllers[i],
                  focusNode: _focusNodes[i],
                  enabled: widget.enabled,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 6,
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: widget.placeholder,
                    filled: false,
                    border: const UnderlineInputBorder(),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: context.colorScheme.primary, width: 2),
                    ),
                    errorBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: context.colorScheme.error)),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: context.colorScheme.error, width: 2),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    color: context.colorScheme.onSurface,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) {
                    if (value.length > 1) {
                      _handlePaste(value, i);
                      return;
                    }

                    if (_lastDeletedIndex != null &&
                        _lastDeletedIndex == i &&
                        value.isNotEmpty) {
                      _controllers[i].text = value;
                      if (i < 5) _focusNodes[i + 1].requestFocus();
                      _lastDeletedIndex = null;
                      return;
                    }

                    if (value.isNotEmpty && i < 5) {
                      _focusNodes[i + 1].requestFocus();
                    }

                    _lastDeletedIndex = null;
                    _onInputChanged();
                  },
                ),
              ),
            );
          }),
        ),
        if (widget.showErrors && widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 12),
            child: Text(
              widget.errorText!,
              style: TextStyle(
                color: context.colorScheme.error,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:{{app_name}}/core/theme/extensions/textstyles_extension.dart';
import 'package:{{app_name}}/core/theme/extensions/theme_extensions.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    this.onPressed,
    this.child,
    this.enabled = true,
    this.foregroundColor,
    this.backgroundColor,
    this.expanded = true,
    this.childPadding,
  });

  final void Function()? onPressed;
  final Widget? child;
  final bool enabled;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final bool expanded;
  final EdgeInsetsGeometry? childPadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expanded ? double.infinity : null,
      child: ElevatedButton(
        onPressed: enabled
            ? () {
                if (onPressed == null) return;
                onPressed!();
              }
            : null,
        style: ElevatedButton.styleFrom(
          foregroundColor: foregroundColor ?? context.colorScheme.onPrimary,
          backgroundColor: backgroundColor ?? context.colorScheme.primary,
          //disabledBackgroundColor: context.colors.primaryBtnDisabledBackground,
          //disabledForegroundColor: context.colors.primaryBtnDisabledForeground,
          textStyle: context.textStyles.poppins.bodyMed,
          padding: EdgeInsets.zero,
        ),
        child: Padding(
          padding: childPadding ??
              const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
          child: child,
        ),
      ),
    );
  }
}

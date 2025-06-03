import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.expanded = true,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expanded ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        /* style: ElevatedButton.styleFrom(
          textStyle: context.textstyles.roboto.h1Medium,
        ), */
      ),
    );
  }
}

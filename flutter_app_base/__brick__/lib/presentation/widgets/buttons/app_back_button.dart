import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:{{app_name}}/core/theme/extensions/theme_extensions.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;
  final double? size;
  final IconData icon;

  const AppBackButton({
    super.key,
    this.onTap,
    this.color,
    this.size,
    this.icon = Icons.chevron_left,
  });

  @override
  Widget build(BuildContext context) {
    if (!context.canPop()) return const SizedBox();

    return IconButton(
      onPressed: onTap ?? () => context.pop(),
      icon: Icon(
        icon,
        color: context.colorScheme.primary,
        size: size ?? 23.sp,
      ),
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
    );
  }
}

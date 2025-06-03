import 'package:flutter/material.dart';
import 'package:{{app_name}}/core/theme/extensions/theme_extensions.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key, required this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.info_outline,
          size: 32.sp,
          color: context.colorScheme.primary,
        ),
        SizedBox(height: 2.h),
        Text(
          message ?? 'No se encontraron datos',
          //style: context.textstyles.roboto.h3Medium,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:{{app_name}}/core/theme/extensions/theme_extensions.dart';
import 'package:{{app_name}}/presentation/widgets/buttons/app_primary_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.onReintent, this.errorMessage});

  final VoidCallback? onReintent;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 32.sp,
            color: context.colorScheme.error,
          ),
          SizedBox(height: 2.h),
          Text(
            errorMessage ?? 'Error al cargar los datos',
            //style: context.textstyles.roboto.h3Medium,
          ),
          SizedBox(height: 3.h),
          if (onReintent != null)
            AppPrimaryButton(
              onPressed: onReintent,
              expanded: false,
              child: Text('Reintentar'),
            ),
        ],
      ),
    );
  }
}

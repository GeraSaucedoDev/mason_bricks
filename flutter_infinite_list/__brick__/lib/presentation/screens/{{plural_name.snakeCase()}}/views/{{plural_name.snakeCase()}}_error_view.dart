import 'package:flutter/material.dart';
import 'package:{{app_name}}/presentation/widgets/views/error_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class {{plural_name.pascalCase()}}ErrorView extends StatelessWidget {
  const {{plural_name.pascalCase()}}ErrorView({super.key, this.onReintent});

  final VoidCallback? onReintent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: ErrorView(onReintent: onReintent),
    );
  }
}

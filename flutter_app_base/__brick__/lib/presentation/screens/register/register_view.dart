import 'package:flutter/material.dart';
import 'package:{{app_name}}/presentation/screens/register/views/register_code_sent_view.dart';
import 'package:{{app_name}}/presentation/screens/register/views/register_data_view.dart';
import 'package:{{app_name}}/presentation/screens/register/views/register_success_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterView extends StatelessWidget {
  final int? currentStep;
  const RegisterView({
    required this.currentStep,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: currentStep,
              children: const [
                RegisterStepFormView(),
                RegisterCodeSentView(),
                RegisterCompleteSuccess(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

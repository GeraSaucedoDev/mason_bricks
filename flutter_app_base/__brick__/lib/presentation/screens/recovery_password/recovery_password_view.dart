import 'package:flutter/material.dart';
import 'package:{{app_name}}/presentation/screens/recovery_password/views/recovery_password_change_form.dart';
import 'package:{{app_name}}/presentation/screens/recovery_password/views/recovery_password_code_sent_view.dart';
import 'package:{{app_name}}/presentation/screens/recovery_password/views/recovery_password_email_view.dart';
import 'package:{{app_name}}/presentation/screens/recovery_password/views/recovery_password_success.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RecoveryPasswordView extends StatelessWidget {
  final int? currentStep;
  const RecoveryPasswordView({
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
                RecoveryPasswordEmailView(),
                RecoveryPasswordCodeSentView(),
                RecoveryPasswordChangeForm(),
                RecoveryPasswordCompleteSuccess(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{app_name}}/core/localization/extension/localization_extension.dart';
import 'package:{{app_name}}/core/theme/extensions/textstyles_extension.dart';
import 'package:{{app_name}}/core/theme/extensions/theme_extensions.dart';
import 'package:{{app_name}}/presentation/blocs/recovery_password/recovery_password_bloc.dart';
import 'package:{{app_name}}/presentation/widgets/buttons/app_primary_button.dart';
import 'package:{{app_name}}/presentation/widgets/inputs/app_otp_code_input.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RecoveryPasswordCodeSentView extends StatelessWidget {
  const RecoveryPasswordCodeSentView({super.key});

  void _handleSubmit(BuildContext context) {
    context.read<RecoveryPasswordBloc>().add(GoForwardStep());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.l10n.sendCodeTitle,
            style: context.textStyles.poppins.titleLarge,
          ),
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: context.textStyles.poppins.titleMed.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.normal,
                ),
                children: [
                  TextSpan(
                    text: '${context.l10n.resendCodeMessagePrefix} \n ',
                  ),
                  TextSpan(
                    text: context.l10n.resendCodeMessageAction,
                    style: context.textStyles.poppins.titleMed.copyWith(
                      color: context.colorScheme.primary,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context
                            .read<RecoveryPasswordBloc>()
                            .add(SendForgotPasswordCode());
                      },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 6.h),
          SixDigitCodeInput(
            onChanged: (value) =>
                context.read<RecoveryPasswordBloc>().add(OtpCodeChanged(value)),
            enabled: true,
            errorText: context
                .read<RecoveryPasswordBloc>()
                .state
                .otpCode
                .errorMessage(context),
            showErrors: false,
          ),
          SizedBox(height: 6.h),
          AppPrimaryButton(
            backgroundColor: context.colorScheme.primary,
            onPressed: () => _handleSubmit(context),
            child: Text(context.l10n.continue_btn),
          ),
        ],
      ),
    );
  }
}

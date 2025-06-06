import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{app_name}}/core/localization/extension/localization_extension.dart';
import 'package:{{app_name}}/core/theme/extensions/theme_extensions.dart';
import 'package:{{app_name}}/presentation/blocs/register/register_bloc.dart';
import 'package:{{app_name}}/presentation/widgets/buttons/app_primary_button.dart';
import 'package:{{app_name}}/presentation/widgets/inputs/app_otp_code_input.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterCodeSentView extends StatelessWidget {
  const RegisterCodeSentView({super.key});

  void _handleSubmit(BuildContext context) {
    context.read<RegisterBloc>().add(NextStepPressed());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.l10n.sendCodeTitle,
            style: TextStyle(
              color: context.colorScheme.primary,
              fontVariations: const [FontVariation('wght', 700)],
              fontSize: 20.sp,
            ),
          ),
          SizedBox(height: 6.h),
          SizedBox(height: 6.h),
          SixDigitCodeInput(
            onChanged: (value) =>
                context.read<RegisterBloc>().add(OtpCodeChanged(value)),
            enabled: true,
            errorText: context
                .read<RegisterBloc>()
                .state
                .otpCode
                .errorMessage(context),
            showErrors: context.read<RegisterBloc>().state.otpCode.isNotValid &&
                context.read<RegisterBloc>().state.formSubmitted,
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

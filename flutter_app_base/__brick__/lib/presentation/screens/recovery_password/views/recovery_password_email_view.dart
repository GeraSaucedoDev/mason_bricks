import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{app_name}}/core/localization/extension/localization_extension.dart';
import 'package:{{app_name}}/core/theme/extensions/textstyles_extension.dart';
import 'package:{{app_name}}/core/theme/extensions/theme_extensions.dart';
import 'package:{{app_name}}/presentation/blocs/recovery_password/recovery_password_bloc.dart';
import 'package:{{app_name}}/presentation/widgets/buttons/app_primary_button.dart';
import 'package:{{app_name}}/presentation/widgets/inputs/app_email_text_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RecoveryPasswordEmailView extends StatelessWidget {
  const RecoveryPasswordEmailView({super.key});

  void _handleSubmit(BuildContext context) {
    context.read<RecoveryPasswordBloc>().add(GoForwardStep());
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final recoveryBloc = context.read<RecoveryPasswordBloc>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.l10n.forgotPasswordTitle,
          style: context.textStyles.poppins.hMed,
        ),
        SizedBox(height: 6.h),
        BlocBuilder<RecoveryPasswordBloc, RecoveryPasswordState>(
          builder: (context, state) {
            return EmailTextField(
              onChanged: (value) => recoveryBloc.add(EmailChanged(value)),
              enabled: !state.isLoading,
            );
          },
        ),
        SizedBox(height: 1.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Text(
            context.l10n.forgotPasswordInsertEmail,
            style: context.textStyles.poppins.bodySmall
                .copyWith(color: context.colorScheme.primary),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 5.h),
        AppPrimaryButton(
          backgroundColor: context.colorScheme.primary,
          onPressed: () => _handleSubmit(context),
          child: Text(context.l10n.continue_btn),
        ),
      ],
    );
  }
}

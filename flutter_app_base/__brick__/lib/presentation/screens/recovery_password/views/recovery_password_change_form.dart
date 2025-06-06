import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{app_name}}/core/localization/extension/localization_extension.dart';
import 'package:{{app_name}}/core/theme/extensions/textstyles_extension.dart';
import 'package:{{app_name}}/core/theme/extensions/theme_extensions.dart';
import 'package:{{app_name}}/presentation/blocs/recovery_password/recovery_password_bloc.dart';
import 'package:{{app_name}}/presentation/widgets/buttons/app_primary_button.dart';
import 'package:{{app_name}}/presentation/widgets/inputs/app_pasword_text_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RecoveryPasswordChangeForm extends StatelessWidget {
  const RecoveryPasswordChangeForm({super.key});

  _handleSubmit(BuildContext context) {
    context.read<RecoveryPasswordBloc>().add(GoForwardStep());
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final formData = context.read<RecoveryPasswordBloc>();

    return BlocBuilder<RecoveryPasswordBloc, RecoveryPasswordState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.l10n.passwordRecoveryInsertNewTitle,
              style: context.textStyles.poppins.titleLarge,
            ),
            SizedBox(height: 5.h),
            PasswordTextField(
              onChanged: (value) => formData.add(PasswordChanged(value)),
              enabled: !state.isLoading,
              errorText: state.confirmedPassword.errorMessage(context),
              // Commented in order to show highilted message on text widge below form
              //showErrors: state.formSubmitted,
            ),
            SizedBox(height: 2.h),
            PasswordTextField(
              onChanged: (value) =>
                  formData.add(ConfirmedPasswordChanged(value)),
              enabled: !state.isLoading,
              errorText: state.confirmedPassword.errorMessage(context),
              showErrors: state.formSubmitted,
            ),
            SizedBox(height: 2.h),
            SizedBox(
              width: double.infinity,
              child: Text(
                context.l10n.passwordRulesDescription,
                style: TextStyle(
                  fontSize: 14.5.sp,
                  color:
                      state.formSubmitted && state.confirmedPassword.isNotValid
                          ? context.colorScheme.error
                          : context.colorScheme.primary,
                ),
              ),
            ),
            SizedBox(height: 6.h),
            AppPrimaryButton(
              backgroundColor: context.colorScheme.primary,
              onPressed: () => _handleSubmit(context),
              child: Text(context.l10n.continue_btn),
            )
          ],
        );
      },
    );
  }
}

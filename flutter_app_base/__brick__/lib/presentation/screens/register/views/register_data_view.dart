import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{app_name}}/core/localization/extension/localization_extension.dart';
import 'package:{{app_name}}/core/theme/extensions/theme_extensions.dart';
import 'package:{{app_name}}/presentation/blocs/register/register_bloc.dart';
import 'package:{{app_name}}/presentation/widgets/buttons/app_primary_button.dart';
import 'package:{{app_name}}/presentation/widgets/inputs/app_email_text_field.dart';
import 'package:{{app_name}}/presentation/widgets/inputs/app_pasword_text_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterStepFormView extends StatelessWidget {
  const RegisterStepFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterBlocState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 22.h),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.l10n.registerAnAccountButton,
                      style: TextStyle(
                        color: context.colorScheme.primary,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    EmailTextField(
                      onChanged: (value) =>
                          context.read<RegisterBloc>().add(EmailChanged(value)),
                      enabled: !(state.status == RegisterStatus.inProgress),
                      errorText: state.email.errorMessage(context),
                      showErrors: state.email.isNotValid && state.formSubmitted,
                    ),
                    SizedBox(height: 2.h),
                    PasswordTextField(
                      onChanged: (value) => context
                          .read<RegisterBloc>()
                          .add(PasswordChanged(value)),
                      enabled: !(state.status == RegisterStatus.inProgress),
                      errorText: state.password.errorMessage(context),
                      showErrors:
                          state.password.isNotValid && state.formSubmitted,
                    ),
                    SizedBox(height: 2.h),
                    PasswordTextField(
                      onChanged: (value) => context
                          .read<RegisterBloc>()
                          .add(ConfirmedPasswordChanged(value)),
                      enabled: !(state.status == RegisterStatus.inProgress),
                      errorText: state.confirmedPassword.errorMessage(context),
                      showErrors: state.confirmedPassword.isNotValid &&
                          state.formSubmitted,
                    ),
                    SizedBox(height: 6.h),
                    AppPrimaryButton(
                      backgroundColor: context.colorScheme.primary,
                      //textColor: context.colorScheme.onPrimary,
                      //borderRadius: 50,
                      //padding: const EdgeInsets.symmetric(
                      //    horizontal: 24, vertical: 16),
                      //textStyle:
                      //    const TextStyle(fontSize: 16, letterSpacing: 1),
                      //width: double.infinity,
                      onPressed: () {
                        context.read<RegisterBloc>().add(NextStepPressed());
                      },
                      child: Text(context.l10n.continue_btn),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

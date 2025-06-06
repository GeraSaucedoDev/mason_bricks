import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:{{app_name}}/core/localization/extension/localization_extension.dart';
import 'package:{{app_name}}/core/theme/extensions/opacity_extension.dart';
import 'package:{{app_name}}/core/theme/extensions/textstyles_extension.dart';
import 'package:{{app_name}}/core/theme/extensions/theme_extensions.dart';
import 'package:{{app_name}}/presentation/blocs/login/login_bloc.dart';
import 'package:{{app_name}}/presentation/screens/login/login_form.dart';
import 'package:{{app_name}}/presentation/widgets/buttons/app_primary_button.dart';
import 'package:{{app_name}}/presentation/widgets/buttons/app_text_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20.h),
                    const LoginForm(),
                    SizedBox(height: 5.h),
                    loginButton(context),
                    SizedBox(height: 2.h),
                    recoveryPasswordButton(context),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            thickness: 1,
            color: context.colorScheme.onSurface.withOpacitye(.5),
          ),
          buildFooter(context),
          SizedBox(height: 1.h),
        ],
      ),
    );
  }

  // Build register button
  Widget buildFooter(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.l10n.registerAnAccountText,
          style: context.textStyles.poppins.labelSmall.copyWith(
            color: context.colorScheme.primary,
          ),
        ),
        AppTextButton(
          expanded: false,
          child: Text(context.l10n.registerAnAccountButton),
          onPressed: () => context.push('/register'),
        ),
      ],
    );
  }

  // Build recovery password button
  AppTextButton recoveryPasswordButton(BuildContext context) {
    return AppTextButton(
      child: Text(context.l10n.forgotPassword),
      onPressed: () => context.go('/login/recovery-password'),
    );
  }

  // Build CTA Login button
  Widget loginButton(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();

    return AppPrimaryButton(
      onPressed: () => loginBloc.add(FormLogInSubmitted()),
      backgroundColor: context.colorScheme.primary,
      child: Text(context.l10n.signIn),
    );
  }
}

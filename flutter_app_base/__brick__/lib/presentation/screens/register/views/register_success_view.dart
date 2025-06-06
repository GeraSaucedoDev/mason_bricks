import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{app_name}}/core/localization/extension/localization_extension.dart';
import 'package:{{app_name}}/core/theme/extensions/theme_extensions.dart';
import 'package:{{app_name}}/core/theme/icons/index.dart';
import 'package:{{app_name}}/presentation/blocs/register/register_bloc.dart';
import 'package:{{app_name}}/presentation/widgets/buttons/app_primary_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterCompleteSuccess extends StatelessWidget {
  const RegisterCompleteSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIcon(AppIcons.success_mark),
          SizedBox(height: 4.h),
          Text(
            context.l10n.registeredAccountTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.colorScheme.primary,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            context.l10n.registeredAccountMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Nunito-sans',
              fontSize: 16.sp,
              color: context.colorScheme.primary,
            ),
          ),
          SizedBox(height: 6.h),
          AppPrimaryButton(
            backgroundColor: context.colorScheme.primary,
            //textColor: context.colorScheme.onPrimary,
            //borderRadius: 50,
            //padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            //textStyle: const TextStyle(fontSize: 16, letterSpacing: 1),
            //width: double.infinity,
            onPressed: () {
              final email = context.read<RegisterBloc>().state.email;
              final password = context.read<RegisterBloc>().state.password;
              context
                  .read<RegisterBloc>()
                  .add(FormLogInSubmitted(email, password));
            },
            child: Text('context.l10n.continue_btn'),
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{app_name}}/presentation/blocs/login/login_bloc.dart';
import 'package:{{app_name}}/presentation/widgets/inputs/app_email_text_field.dart';
import 'package:{{app_name}}/presentation/widgets/inputs/app_pasword_text_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();

    return BlocBuilder<LoginBloc, LoginBlocState>(
      builder: (context, state) {
        return Column(
          spacing: 3.h,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Email field
            EmailTextField(
              onChanged: (value) => loginBloc.add(EmailChanged(value)),
              enabled: !state.isLoading,
              errorText: state.email.errorMessage(context),
              showErrors: state.formSubmitted,
            ),

            // Password field
            PasswordTextField(
              onChanged: (value) => loginBloc.add(PasswordChanged(value)),
              enabled: !state.isLoading,
              errorText: state.password.errorMessage(context),
              showErrors: state.formSubmitted,
            ),
          ],
        );
      },
    );
  }
}

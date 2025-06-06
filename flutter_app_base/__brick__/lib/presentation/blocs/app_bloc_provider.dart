import 'package:flutter/material.dart';
import 'package:{{app_name}}/main_injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{app_name}}/presentation/blocs/app/app_bloc.dart';
import 'package:{{app_name}}/presentation/blocs/auth/auth_bloc.dart';
import 'package:{{app_name}}/presentation/blocs/login/login_bloc.dart';
import 'package:{{app_name}}/presentation/blocs/recovery_password/recovery_password_bloc.dart';
import 'package:{{app_name}}/presentation/blocs/register/register_bloc.dart';

class AppBlocProvider extends StatelessWidget {
  const AppBlocProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AppBloc>()),
        BlocProvider(create: (context) => sl<LoginBloc>()),
        BlocProvider(create: (context) => sl<RecoveryPasswordBloc>()),
        BlocProvider(create: (context) => sl<RegisterBloc>()),
        BlocProvider(create: (context) => sl<AuthBloc>()),
      ],
      child: child,
    );
  }
}

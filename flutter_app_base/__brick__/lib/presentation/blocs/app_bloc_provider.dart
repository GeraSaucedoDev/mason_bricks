import 'package:flutter/material.dart';
import 'package:{{app_name}}/main_injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{app_name}}/presentation/blocs/app/app_bloc.dart';


class AppBlocProvider extends StatelessWidget {
  const AppBlocProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AppBloc>()),
      ],
      child: child,
    );
  }
}

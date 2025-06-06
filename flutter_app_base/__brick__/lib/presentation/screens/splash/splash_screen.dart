import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:{{app_name}}/presentation/blocs/auth/auth_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashScreen extends StatefulWidget {
  static const String screenName = 'splash-screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// Initial data retriving
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(CheckAuthStatus());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) {
            return previous.authStatus != current.authStatus;
          },
          listener: (context, state) {
            if (state.authStatus == AuthStatus.authenticated) {
              context.go('/');
              return;
            }

            if (state.authStatus == AuthStatus.notAuthenticated) {
              context.go('/login');
              return;
            }
          },
        ),
      ],
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity),
            SizedBox(
              width: 65.sp,
              child: FlutterLogo(),
            ),
            SizedBox(height: 4.h),
            LinearProgressIndicator()
          ],
        ),
      ),
    );
  }
}

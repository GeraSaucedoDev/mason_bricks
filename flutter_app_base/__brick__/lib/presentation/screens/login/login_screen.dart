import 'package:flutter/material.dart';
import 'package:{{app_name}}/presentation/screens/login/login_bloc_listener.dart';
import 'package:{{app_name}}/presentation/screens/login/login_view.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String screenName = 'login-screen';

  @override
  Widget build(BuildContext context) {
    return LoginBlocListener(
      child: Scaffold(
        body: const SafeArea(
          child: LoginView(),
        ),
      ),
    );
  }
}

import 'package:go_router/go_router.dart';
import 'package:{{app_name}}/core/navigation/routes/app_auth_redirect.dart';
import 'package:{{app_name}}/presentation/screens/splash/splash_screen.dart';
import 'package:{{app_name}}/presentation/screens/home/home_screen.dart';
import 'package:{{app_name}}/presentation/screens/login/login_screen.dart';
import 'package:{{app_name}}/presentation/screens/recovery_password/recovery_password_screen.dart';
import 'package:{{app_name}}/presentation/screens/register/register_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: SplashScreen.screenName,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      name: LoginScreen.screenName,
      builder: (context, state) => const LoginScreen(),
      routes: [
        GoRoute(
          path: 'recovery-password',
          name: RecoveryPasswordScreen.screenName,
          builder: (context, state) => const RecoveryPasswordScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/register',
      name: RegisterScreen.screenName,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/',
      name: HomeScreen.screenName,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
  redirect: authRedirect,
);

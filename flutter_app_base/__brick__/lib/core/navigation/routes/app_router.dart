import 'package:go_router/go_router.dart';
import 'package:{{app_name}}/presentation/screens/home/home_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: HomeScreen.route,
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
      routes: [],
    ),
  ],
  //redirect: authRedirect,
);

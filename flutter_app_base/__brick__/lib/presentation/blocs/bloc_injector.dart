import 'package:{{app_name}}/main_injector.dart';
import 'package:{{app_name}}/presentation/blocs/app/app_bloc.dart';
import 'package:{{app_name}}/presentation/blocs/auth/auth_bloc.dart';
import 'package:{{app_name}}/presentation/blocs/login/login_bloc.dart';
import 'package:{{app_name}}/presentation/blocs/recovery_password/recovery_password_bloc.dart';
import 'package:{{app_name}}/presentation/blocs/register/register_bloc.dart';

void blocInjector() {
  sl.registerFactory(() => AppBloc(configRepository: sl()));
  sl.registerFactory(() => AuthBloc(authRepository: sl(), tokenManager: sl()));

  sl.registerFactory(
    () => RecoveryPasswordBloc(authRepository: sl()),
  );

  sl.registerFactory(() => RegisterBloc(
      registerRepository: sl(), authRepository: sl(), userService: sl()));

  sl.registerFactory(
    () => LoginBloc(
      repository: sl(),
      tokenManager: sl(),
      userManager: sl(),
      userService: sl(),
    ),
  );
}

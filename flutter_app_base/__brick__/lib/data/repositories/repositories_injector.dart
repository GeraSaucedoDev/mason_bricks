import 'package:{{app_name}}/data/repositories/auth_repository.dart';
import 'package:{{app_name}}/data/repositories/config_repository.dart';
import 'package:{{app_name}}/data/repositories/register_repository.dart';
import 'package:{{app_name}}/main_injector.dart';

void repositoriesInjector() {
  sl.registerLazySingleton(() => ConfigRepository(configManager: sl()));
  sl.registerLazySingleton(() => RegisterRepository(apiClient: sl()));

  sl.registerLazySingleton(() => AuthRepository(
        apiClient: sl(),
        tokenManager: sl(),
        userService: sl(),
      ));
}

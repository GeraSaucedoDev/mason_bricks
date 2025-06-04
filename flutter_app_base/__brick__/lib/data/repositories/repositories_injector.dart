import 'package:{{app_name}}/data/repositories/config_repository.dart';
import 'package:{{app_name}}/main_injector.dart';

void repositoriesInjector() {
  sl.registerLazySingleton(() => ConfigRepository(configManager: sl()));
}

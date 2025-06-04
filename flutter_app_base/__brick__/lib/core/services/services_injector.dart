import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:{{app_name}}/core/services/api/api_client.dart';
import 'package:{{app_name}}/core/services/config_manager/config_manager.dart';
import 'package:{{app_name}}/core/services/storage/local_storage_service.dart';
import 'package:{{app_name}}/core/services/storage/secure_storage_service.dart';
import 'package:{{app_name}}/core/services/storage/token_manager.dart';
import 'package:{{app_name}}/main_injector.dart';
import 'package:{{app_name}}/core/services/user/user_manager.dart';
import 'package:{{app_name}}/core/services/user/user_service.dart';


/// Services that can be used in the app,
///
/// This method helps to inject the dependencies related to the services.
Future<void> servicesInjector() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(Dio.new);
  sl.registerLazySingleton(FlutterSecureStorage.new);

  // Internal
  sl.registerLazySingleton(() => SecureStorageService(secureStorage: sl()));
  sl.registerLazySingleton(() => TokenManager(sl()));
  sl.registerLazySingleton(() => UserManager(storage: sl()));
  sl.registerLazySingleton(() => LocalStorageService(storage: sl()));
  sl.registerLazySingleton(() => ApiClient(secureStorage: sl(), dio: sl()));
  sl.registerLazySingleton(() => ConfigManager());
  sl.registerLazySingleton(() => UserService(apiClient: sl(), storage: sl()));
}

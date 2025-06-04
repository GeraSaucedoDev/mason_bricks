import 'package:{{app_name}}/main_injector.dart';
import 'package:{{app_name}}/presentation/blocs/app/app_bloc.dart';

void blocInjector() {
  sl.registerFactory(() => AppBloc(configRepository: sl()));
}

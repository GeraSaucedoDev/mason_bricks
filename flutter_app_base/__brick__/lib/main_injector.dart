import 'package:get_it/get_it.dart';
import 'package:{{app_name}}/core/services/services_injector.dart';
import 'package:{{app_name}}/data/repositories/repositories_injector.dart';
import 'package:{{app_name}}/presentation/blocs/bloc_injector.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await servicesInjector();
  blocInjector();
  repositoriesInjector();
}

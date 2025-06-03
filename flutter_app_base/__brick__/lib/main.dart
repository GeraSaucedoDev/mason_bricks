import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:{{app_name}}/main_app.dart';
import 'package:{{app_name}}/presentation/blocs/app_bloc_provider.dart';
import 'package:{{app_name}}/main_injector.dart' as di;
import 'package:{{app_name}}/presentation/blocs/bloc_observer.dart';

import 'package:intl/intl.dart';

Future<void> main() async {
  await _mainConfig();
  runApp(const AppBlocProvider(child: MainApp()));
}

Future<void> _mainConfig() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Initialize dependency injection service
  await di.init();

  // Force vertical orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  Intl.defaultLocale = 'es';

  Bloc.observer = MyBlocObserver();
}

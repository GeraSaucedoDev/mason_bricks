import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{app_name}}/core/services/logger/app_logger.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    AppLogger.i(
        'Bloc: ${bloc.runtimeType}, Event: $event - ${DateTime.now().toString()}');
  }

  /*  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    AppLogger.i(
        'Transition: ${transition.event} -> ${transition.currentState} -> ${transition.nextState}');
  } */

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    AppLogger.i('========= Bloc: ${bloc.runtimeType} CERRADO ==========');
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    AppLogger.i('========= Bloc: ${bloc.runtimeType}, CREADO =====');
  }
}

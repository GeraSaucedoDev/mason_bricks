import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{app_name}}/core/services/logger/app_logger.dart';
import 'package:{{app_name}}/data/repositories/config_repository.dart';

part 'app_events.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required ConfigRepository configRepository})
    : _configRepository = configRepository,
      // Bloc events
      super(const AppState()) {
    on<GetAppConfig>(_onGetAppConfig);
    on<CleanState>(_onCleanState);
    on<CleanError>(_onCleanError);
  }

  final ConfigRepository _configRepository;

  void _onGetAppConfig(GetAppConfig event, Emitter<AppState> emit) async {
    try {
      emit(
        state.copyWith(isLoading: true, dataLoaded: false, errorMessage: ''),
      );

      await _configRepository.getAppConfig();

      emit(state.copyWith(isLoading: false, dataLoaded: true));
    } catch (e, stack) {
      AppLogger.e('$runtimeType | _onGetAppConfig()', e, stack);
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Error al obtener la configuración',
        ),
      );
    }
  }

  void _onCleanError(CleanError event, Emitter<AppState> emit) {
    emit(state.copyWith(errorMessage: ''));
  }

  void _onCleanState(CleanState event, Emitter<AppState> emit) {
    emit(const AppState());
  }
}

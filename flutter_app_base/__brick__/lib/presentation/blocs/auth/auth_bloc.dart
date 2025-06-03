import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mason_test_a/core/services/logger/app_logger.dart';
import 'package:mason_test_a/data/repositories/auth_repository.dart';
import 'package:mason_test_a/domain/models/user.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
 
        super(const AuthState()) {
    on<ChangeAuthStatus>(_onChangeAuthStatus);
    on<LogoutRequested>(_onLogoutRequested);
    on<ChangeAuthUser>(_onChangeAuthUser);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<CleanAuthError>(_onCleanAuthError);
  }

  final AuthRepository _authRepository;


  _onChangeAuthStatus(
    ChangeAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(authStatus: event.authStatus));
  }

  void _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final user = await _authRepository.isUserLogged();
      //final isFederated = await _authRepository.getFederated();

      if (user == null) {
        emit(state.copyWith(
          authStatus: AuthStatus.notAuthenticated,
          isLoading: false,
          //isFederated: isFederated
        ));
        add(LogoutRequested());
        return;
      }

      emit(state.copyWith(
        authStatus: AuthStatus.authenticated,
        isLoading: false,
        user: user,
        //isFederated: isFederated
      ));
    } catch (e) {
      AppLogger.e('AuthBloc | _onCheckAuthStatus() \n\n$e');

      emit(state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        isLoading: false,
      ));
      add(LogoutRequested());
    }
  }

  _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      //final isFederated = await _tokenManager.isFederatedToken();
      await _authRepository.logout();
      //await _tokenManager.saveIsFederated(false);
      emit(state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: User(),
        isLoading: false,
      ));
    } catch (e) {
      AppLogger.e('AuthBloc | _onLogoutRequested() \n\n$e');

      emit(state.copyWith(
        errorMessage: 'auth_logout_error_message',
        isLoading: false,
      ));
    }
  }

  void _onCleanAuthError(CleanAuthError event, Emitter<AuthState> emit) {
    emit(state.copyWith(errorMessage: ''));
  }

  Future<void> _onChangeAuthUser(
      ChangeAuthUser event, Emitter<AuthState> emit) async {
    //final isFederated = await _authRepository.getFederated();
    emit(state.copyWith(user: event.user));
  }
}

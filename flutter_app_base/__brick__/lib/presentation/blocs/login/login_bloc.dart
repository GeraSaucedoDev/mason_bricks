import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:{{app_name}}/core/services/storage/token_manager.dart';
import 'package:{{app_name}}/core/services/user/user_manager.dart';
import 'package:{{app_name}}/core/services/user/user_service.dart';
import 'package:{{app_name}}/data/repositories/auth_repository.dart';
import 'package:{{app_name}}/data/validators/email.dart';
import 'package:{{app_name}}/data/validators/password.dart';
import 'package:{{app_name}}/domain/models/user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  LoginBloc({
    required AuthRepository repository,
    required UserService userService,
    required TokenManager tokenManager,
    required UserManager userManager,
  })  : _authRepository = repository,
        _userService = userService,
        //_tokenManager = tokenManager,
        //_userManager = userManager,
        super(const LoginBlocState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<FormLogInSubmitted>(_onFormLogInSubmitted);
    on<CleanError>(_onCleanError);
    on<CleanState>(_onCleanState);
  }
  final AuthRepository _authRepository;
  final UserService _userService;
  //final TokenManager _tokenManager;
  //final UserManager _userManager;

  void _onEmailChanged(EmailChanged event, Emitter<LoginBlocState> emit) {
    final email = EmailInput.dirty(event.email);
    emit(state.copyWith(email: email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginBlocState> emit) {
    final password = PasswordInput.dirty(event.password);
    emit(state.copyWith(password: password));
  }

  void _onFormLogInSubmitted(
    FormLogInSubmitted event,
    Emitter<LoginBlocState> emit,
  ) async {
    // Validate state fields
    final isValid = _isValidForm();

    if (!isValid) {
      // Return error message if form fields are not valid
      emit(state.copyWith(
        errorMessage: 'login_generic_error_message',
        formSubmitted: true,
      ));
      return;
    }

    emit(state.copyWith(
      isLoading: true,
      formSubmitted: true,
    ));

    try {
      final accessToken = await _authRepository.loginWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      final user = await _userService.getUserData(accessToken);

      emit(
        state.copyWith(
          user: user,
          successLogin: true,
          isLoading: false,
        ),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        emit(state.copyWith(
          errorMessage: 'login_form_invalid_credentials',
          isLoading: false,
        ));
        return;
      }

      emit(state.copyWith(
        errorMessage: 'login_generic_error_message',
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'login_generic_error_message',
        isLoading: false,
      ));
    }
  }

  bool _isValidForm() {
    return Formz.validate([
      state.email,
      state.password,
    ]);
  }

  void _onCleanError(CleanError event, Emitter<LoginBlocState> emit) {
    emit(state.copyWith(errorMessage: ''));
  }

  void _onCleanState(CleanState event, Emitter<LoginBlocState> emit) {
    emit(const LoginBlocState());
  }
}

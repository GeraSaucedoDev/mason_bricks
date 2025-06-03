import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mason_test_a/core/services/storage/token_manager.dart';
import 'package:mason_test_a/core/services/user/user_manager.dart';
import 'package:mason_test_a/core/services/user/user_service.dart';
import 'package:mason_test_a/data/repositories/auth_repository.dart';
import 'package:mason_test_a/data/validators/email.dart';
import 'package:mason_test_a/data/validators/password.dart';
import 'package:mason_test_a/domain/models/user.dart';

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

    emit(state.copyWith(
      email: email,
      status: FormzSubmissionStatus.initial,
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginBlocState> emit) {
    final password = PasswordInput.dirty(event.password);

    emit(state.copyWith(
      password: password,
      status: FormzSubmissionStatus.initial,
    ));
  }

  void _onFormLogInSubmitted(
    FormLogInSubmitted event,
    Emitter<LoginBlocState> emit,
  ) async {
    final isValid = Formz.validate([event.email, event.password]);

    emit(state.copyWith(
      formSubmitted: true,
      status: isValid
          ? FormzSubmissionStatus.inProgress
          : FormzSubmissionStatus.failure,
    ));

    if (!isValid) {
      emit(state.copyWith(
        errorMessage: 'login_form_verify_data',
      ));
      return;
    }

    try {
      final accessToken = await _authRepository.loginWithEmailAndPassword(
        email: event.email.value,
        password: event.password.value,
      );
      final user = await _userService.getUserData(accessToken);

      emit(state.copyWith(
        user: user,
        status: FormzSubmissionStatus.success,
        errorMessage: '',
      ));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: 'login_form_invalid_credentials',
        ));
        return;
      }

      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: 'login_generic_error_message',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: 'login_generic_error_message',
      ));
    }
  }

  void _onCleanError(CleanError event, Emitter<LoginBlocState> emit) {
    emit(state.copyWith(errorMessage: ''));
  }

  void _onCleanState(CleanState event, Emitter<LoginBlocState> emit) {
    emit(const LoginBlocState());
  }
}

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mason_test_a/core/services/user/user_service.dart';
import 'package:mason_test_a/data/repositories/auth_repository.dart';
import 'package:mason_test_a/data/repositories/register_repository.dart';
import 'package:mason_test_a/data/validators/email.dart';
import 'package:mason_test_a/data/validators/field_confirm_password.dart';
import 'package:mason_test_a/data/validators/otp_code_input.dart';
import 'package:mason_test_a/data/validators/password.dart';
import 'package:mason_test_a/domain/models/user.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterBlocEvent, RegisterBlocState> {
  RegisterBloc({
    required RegisterRepository registerRepository,
    required AuthRepository authRepository,
    required UserService userService,
  })  : _registerRepository = registerRepository,
        _authRepository = authRepository,
        _userService = userService,
        super(const RegisterBlocState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmedPasswordChanged>(_onConfirmedPasswordChanged);
    on<OtpCodeChanged>(_onOtpCodeChanged);
    on<ValidateOtpCode>(_onValidateOtpCode);
    on<NextStepPressed>(_onNextStepPressed);
    on<PreviousStepPressed>(_onPreviousStepPressed);
    on<FormLogInSubmitted>(_onFormLogInSubmitted);
    on<CleanError>(_onCleanError);
    on<CleanState>(_onCleanState);
  }

  final RegisterRepository _registerRepository;
  final AuthRepository _authRepository;
  final UserService _userService;

  void _onEmailChanged(EmailChanged event, Emitter<RegisterBlocState> emit) {
    final email = EmailInput.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: FormzSubmissionStatus.initial,
      errorMessage: '',
    ));
  }

  void _onPasswordChanged(
      PasswordChanged event, Emitter<RegisterBlocState> emit) {
    final password = PasswordInput.dirty(event.password);
    final confirmedPassword = state.confirmedPassword.value.isNotEmpty
        ? state.confirmedPassword.copyWith(password: event.password)
        : state.confirmedPassword;
    emit(state.copyWith(
      password: password,
      confirmedPassword: confirmedPassword,
      status: FormzSubmissionStatus.initial,
      errorMessage: '',
    ));
  }

  void _onConfirmedPasswordChanged(
      ConfirmedPasswordChanged event, Emitter<RegisterBlocState> emit) {
    final confirmedPassword = ConfirmedPasswordInput.dirty(
      password: state.password.value,
      value: event.confirmedPassword,
    );
    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: FormzSubmissionStatus.initial,
      errorMessage: '',
    ));
  }

  void _onOtpCodeChanged(
      OtpCodeChanged event, Emitter<RegisterBlocState> emit) {
    final otpCode = OtpCodeInput.dirty(event.otpCode);
    emit(state.copyWith(
      otpCode: otpCode,
      otpValidated: false,
      status: FormzSubmissionStatus.initial,
      errorMessage: '',
    ));
  }

  void _onPreviousStepPressed(
    PreviousStepPressed event,
    Emitter<RegisterBlocState> emit,
  ) {
    if (state.currentStep == 0) return;
    emit(state.copyWith(currentStep: state.currentStep - 1));
  }

  void _onNextStepPressed(
    NextStepPressed event,
    Emitter<RegisterBlocState> emit,
  ) async {
    switch (state.currentStep) {
      case 0:
        final emailValid = state.email.isValid;
        final passwordValid = state.password.isValid;
        final confirmValid = state.confirmedPassword.isValid;

        if (emailValid && passwordValid && confirmValid) {
          emit(state.copyWith(
              isLoading: true, errorMessage: '', formSubmitted: true));

          try {
            await _registerRepository.registerUser(
              email: state.email.value,
              password: state.password.value,
            );

            await _registerRepository.sendConfirmationCode(
                email: state.email.value);

            emit(state.copyWith(
              currentStep: 1,
              isLoading: false,
              errorMessage: '',
            ));
          } catch (e) {
            emit(state.copyWith(
              isLoading: false,
              errorMessage: 'register_otp_send_failed',
            ));
          }
        } else {
          emit(state.copyWith(
            formSubmitted: true,
            errorMessage: 'register_form_verify_data',
          ));
        }
        break;

      case 1:
        if (state.otpCode.isValid) {
          emit(state.copyWith(
              isLoading: true, errorMessage: '', formSubmitted: true));

          try {
            final isValid = await _registerRepository.validateOtpCode(
              email: state.email.value,
              otpCode: state.otpCode.value,
            );

            if (isValid) {
              emit(state.copyWith(
                currentStep: 2,
                errorMessage: '',
                isLoading: false,
                otpValidated: true,
              ));
            } else {
              emit(state.copyWith(
                formSubmitted: true,
                errorMessage: 'register_otp_code_not_validated',
                isLoading: false,
              ));
            }
          } catch (e) {
            emit(state.copyWith(
              isLoading: false,
              errorMessage: 'register_otp_validation_error',
            ));
          }
        } else {
          emit(state.copyWith(
            formSubmitted: true,
            errorMessage: 'register_otp_code_not_valid',
          ));
        }
        break;

      case 2:
        break;
    }
  }

  Future<void> _onValidateOtpCode(
    ValidateOtpCode event,
    Emitter<RegisterBlocState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
      status: FormzSubmissionStatus.inProgress,
      errorMessage: '',
    ));

    try {
      final isValid = await _registerRepository.validateOtpCode(
        email: event.email,
        otpCode: event.otpCode,
      );

      if (isValid) {
        emit(state.copyWith(
          otpValidated: true,
          isLoading: false,
          errorMessage: '',
        ));
      } else {
        emit(state.copyWith(
          otpValidated: false,
          isLoading: false,
          status: FormzSubmissionStatus.failure,
          errorMessage: 'register_otp_code_invalid',
        ));
      }
    } catch (_) {
      emit(state.copyWith(
        otpValidated: false,
        isLoading: false,
        status: FormzSubmissionStatus.failure,
        errorMessage: 'register_otp_code_validation_error',
      ));
    }
  }

  void _onFormLogInSubmitted(
    FormLogInSubmitted event,
    Emitter<RegisterBlocState> emit,
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

  void _onCleanError(CleanError event, Emitter<RegisterBlocState> emit) {
    emit(state.copyWith(errorMessage: ''));
  }

  void _onCleanState(CleanState event, Emitter<RegisterBlocState> emit) {
    emit(const RegisterBlocState());
  }
}

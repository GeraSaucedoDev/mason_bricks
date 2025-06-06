import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:{{app_name}}/data/repositories/auth_repository.dart';
import 'package:{{app_name}}/data/validators/email.dart';
import 'package:{{app_name}}/data/validators/field_confirm_password.dart';
import 'package:{{app_name}}/data/validators/otp_code_input.dart';
import 'package:{{app_name}}/data/validators/password.dart';
import '../../../core/services/logger/app_logger.dart';

part 'recovery_password_event.dart';
part 'recovery_password_state.dart';

class RecoveryPasswordBloc
    extends Bloc<RecoveryPasswordEvent, RecoveryPasswordState> {
  RecoveryPasswordBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const RecoveryPasswordState()) {
    on<SubmitRecoveryPassword>(_onSubmitRecoveryPassword);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmedPasswordChanged>(_onConfirmedPasswordChanged);
    on<OtpCodeChanged>(_onOtpCodeChanged);
    on<SendForgotPasswordCode>(_onSendForgotPasswordCode);
    on<GoForwardStep>(_onGoForwardStep);
    on<GoBackStep>(_onGoBackStep);
    on<CurrentStepChanged>(_onCurrentStepChanged);
    on<CleanError>(_onCleanError);
    on<CleanState>(_onCleanState);
  }

  final AuthRepository _authRepository;

  void _onSendForgotPasswordCode(
    SendForgotPasswordCode event,
    Emitter<RecoveryPasswordState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, formSubmitted: true));

      final isValidEmail = _isEmailValid();

      if (!isValidEmail) {
        emit(state.copyWith(isLoading: false));
        return;
      }

      await _authRepository.sendForgotPasswordCode(email: state.email.value);

      emit(state.copyWith(
        currentStep: 1,
        isLoading: false,
      ));
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        emit(
          state.copyWith(
              isLoading: false,
              errorMessage: 'recovery_password_bloc_unverified_account_error'),
        );
        return;
      }

      emit(
        state.copyWith(
          errorMessage: 'recovery_password_bloc_send_otp_code_error',
          isLoading: false,
        ),
      );
    } catch (e) {
      AppLogger.e('AuthBloc | _onSendOTPCode(): \n \n$e');
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'recovery_password_bloc_send_otp_code_error',
        ),
      );
    }
  }

  _onSubmitRecoveryPassword(
    SubmitRecoveryPassword event,
    Emitter<RecoveryPasswordState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, formSubmitted: true));

      AppLogger.i('''
        Otp code: ${state.otpCode.value}
        Email: ${state.email.value}
        Password: ${state.password.value}
        ConfirmedPassword: ${state.confirmedPassword.value}
      ''');

      await _authRepository.updatePassword(
        email: state.email.value,
        newPassword: state.password.value,
        confirmationCode: state.otpCode.value,
      );

      emit(state.copyWith(
        currentStep: state.currentStep + 1,
        isLoading: false,
      ));
    } catch (e) {
      AppLogger.e('$e');
      emit(
        state.copyWith(
          errorMessage: 'recovery_password_form_general_error_message',
          isLoading: false,
        ),
      );
    }
  }

  void _onCurrentStepChanged(
    CurrentStepChanged event,
    Emitter<RecoveryPasswordState> emit,
  ) {
    emit(state.copyWith(
      currentStep: event.currentStep,
    ));
  }

  void _onEmailChanged(
    EmailChanged event,
    Emitter<RecoveryPasswordState> emit,
  ) {
    final email = EmailInput.dirty(event.email.trim());
    emit(state.copyWith(email: email));
  }

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<RecoveryPasswordState> emit,
  ) {
    final password = PasswordInput.dirty(event.password.trim());
    final confirmedPassword = ConfirmedPasswordInput.dirty(
      password: event.password.trim(),
      value: state.confirmedPassword.value,
    );

    emit(state.copyWith(
      password: password,
      confirmedPassword: confirmedPassword,
    ));
  }

  void _onConfirmedPasswordChanged(
    ConfirmedPasswordChanged event,
    Emitter<RecoveryPasswordState> emit,
  ) {
    final confirmedPassword = ConfirmedPasswordInput.dirty(
      password: state.password.value,
      value: event.confirmedPassword.trim(),
    );

    emit(state.copyWith(confirmedPassword: confirmedPassword));
  }

  void _onOtpCodeChanged(
      OtpCodeChanged event, Emitter<RecoveryPasswordState> emit) {
    final code = OtpCodeInput.dirty(event.code.trim());
    emit(state.copyWith(otpCode: code));
  }

  bool _isEmailValid() {
    return Formz.validate([
      state.email,
    ]);
  }

  void _onGoForwardStep(
      GoForwardStep event, Emitter<RecoveryPasswordState> emit) {
    emit(state.copyWith(
        formSubmitted: state.currentStep == 2 ? true : false, isLoading: true));

    if (!_isCurrentStepValid()) {
      final String? errorMessage = _getCurrentStepError();
      emit(state.copyWith(errorMessage: errorMessage, isLoading: false));
      return;
    }
    if (state.currentStep == 0) {
      add(SendForgotPasswordCode());
      return;
    }
    if (state.currentStep == 2) {
      add(SubmitRecoveryPassword());
      return;
    }

    emit(state.copyWith(currentStep: state.currentStep + 1, isLoading: false));
  }

  bool _isCurrentStepValid() {
    switch (state.currentStep) {
      case 0:
        return Formz.validate([state.email]);
      case 1:
        return Formz.validate([state.otpCode]);
      case 2:
        return Formz.validate([
          state.password,
          state.confirmedPassword,
          state.otpCode,
        ]);
      case 3:
        return true;

      default:
        return false;
    }
  }

  String? _getCurrentStepError() {
    switch (state.currentStep) {
      case 0:
        if (!state.email.isValid) {
          return 'error_step_0';
        }
        return null;
      case 1:
        if (!state.otpCode.isValid) {
          return 'error_step_1';
        }
        return null;
      case 2:
        if (!state.password.isValid) {
          return 'error_step_2';
        }
        if (!state.confirmedPassword.isValid) {
          return 'error_password';
        }

        return null;

      case 3:
        return null;

      default:
        return null;
    }
  }

  void _onGoBackStep(GoBackStep event, Emitter<RecoveryPasswordState> emit) {
    if (state.currentStep == 0) return;

    emit(state.copyWith(currentStep: state.currentStep - 1));
  }

  void _onCleanError(CleanError event, Emitter<RecoveryPasswordState> emit) {
    emit(state.copyWith(errorMessage: ''));
  }

  void _onCleanState(CleanState event, Emitter<RecoveryPasswordState> emit) {
    emit(const RecoveryPasswordState());
  }
}

part of 'recovery_password_bloc.dart';

abstract class RecoveryPasswordEvent extends Equatable {
  const RecoveryPasswordEvent();

  @override
  List<Object?> get props => [];
}

class EmailChanged extends RecoveryPasswordEvent {
  const EmailChanged(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

class OtpCodeChanged extends RecoveryPasswordEvent {
  const OtpCodeChanged(this.code);

  final String code;

  @override
  List<Object> get props => [code];
}

class PasswordChanged extends RecoveryPasswordEvent {
  const PasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class ConfirmedPasswordChanged extends RecoveryPasswordEvent {
  const ConfirmedPasswordChanged(this.confirmedPassword);

  final String confirmedPassword;

  @override
  List<Object> get props => [confirmedPassword];
}

class SubmitRecoveryPassword extends RecoveryPasswordEvent {}

class CurrentStepChanged extends RecoveryPasswordEvent {
  const CurrentStepChanged(this.currentStep);

  final int currentStep;

  @override
  List<Object> get props => [currentStep];
}

class SendForgotPasswordCode extends RecoveryPasswordEvent {}

class CleanError extends RecoveryPasswordEvent {}

class CleanState extends RecoveryPasswordEvent {}

class GoForwardStep extends RecoveryPasswordEvent {}

class GoBackStep extends RecoveryPasswordEvent {}

part of 'register_bloc.dart';

abstract class RegisterBlocEvent extends Equatable {
  const RegisterBlocEvent();

  @override
  List<Object?> get props => [];
}

class EmailChanged extends RegisterBlocEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends RegisterBlocEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class ConfirmedPasswordChanged extends RegisterBlocEvent {
  final String confirmedPassword;

  const ConfirmedPasswordChanged(this.confirmedPassword);

  @override
  List<Object?> get props => [confirmedPassword];
}

class OtpCodeChanged extends RegisterBlocEvent {
  final String otpCode;

  const OtpCodeChanged(this.otpCode);

  @override
  List<Object?> get props => [otpCode];
}

class NextStepPressed extends RegisterBlocEvent {
  const NextStepPressed();
}

class PreviousStepPressed extends RegisterBlocEvent {
  const PreviousStepPressed();
}

class ValidateOtpCode extends RegisterBlocEvent {
  final String email;
  final String otpCode;

  const ValidateOtpCode({required this.email, required this.otpCode});

  @override
  List<Object?> get props => [email, otpCode];
}

class FormLogInSubmitted extends RegisterBlocEvent {
  final EmailInput email;
  final PasswordInput password;

  const FormLogInSubmitted(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class CleanError extends RegisterBlocEvent {
  const CleanError();
}

class CleanState extends RegisterBlocEvent {
  const CleanState();
}

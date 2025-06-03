part of 'recovery_password_bloc.dart';

class RecoveryPasswordState extends Equatable with FormzMixin {
  final EmailInput email;
  final OtpCodeInput otpCode;
  final PasswordInput password;
  final ConfirmedPasswordInput confirmedPassword;
  final String errorMessage;
  final bool isLoading;
  final bool formSubmitted;
  final int currentStep;

  const RecoveryPasswordState({
    this.email = const EmailInput.pure(),
    this.otpCode = const OtpCodeInput.pure(),
    this.password = const PasswordInput.pure(),
    this.confirmedPassword = const ConfirmedPasswordInput.pure(),
    this.errorMessage = '',
    this.isLoading = false,
    this.currentStep = 0,
    this.formSubmitted = false,
  });

  @override
  List<FormzInput> get inputs => [
        email,
        password,
        confirmedPassword,
        otpCode,
      ];

  @override
  List<Object?> get props => [
        email,
        errorMessage,
        isLoading,
        currentStep,
        formSubmitted,
        otpCode,
        password,
        confirmedPassword,
      ];

  RecoveryPasswordState copyWith({
    EmailInput? email,
    OtpCodeInput? otpCode,
    PasswordInput? password,
    ConfirmedPasswordInput? confirmedPassword,
    String? errorMessage,
    bool? isLoading,
    bool? formSubmitted,
    int? currentStep,
  }) {
    return RecoveryPasswordState(
      email: email ?? this.email,
      otpCode: otpCode ?? this.otpCode,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      formSubmitted: formSubmitted ?? this.formSubmitted,
      currentStep: currentStep ?? this.currentStep,
    );
  }
}

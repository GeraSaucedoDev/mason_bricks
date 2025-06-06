part of 'register_bloc.dart';

class RegisterBlocState extends Equatable {
  final EmailInput email;
  final PasswordInput password;
  final ConfirmedPasswordInput confirmedPassword;
  final OtpCodeInput otpCode;

  final String errorMessage;
  final bool isLoading;
  final bool formSubmitted;
  final RegisterStatus status;
  final bool otpValidated;
  final User? user;

  final int currentStep;
  final bool isStepValid;

  const RegisterBlocState({
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.confirmedPassword = const ConfirmedPasswordInput.pure(),
    this.otpCode = const OtpCodeInput.pure(),
    this.errorMessage = '',
    this.isLoading = false,
    this.formSubmitted = false,
    this.status = RegisterStatus.initial,
    this.otpValidated = false,
    this.user,
    this.currentStep = 0,
    this.isStepValid = false,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        confirmedPassword,
        otpCode,
        errorMessage,
        isLoading,
        formSubmitted,
        status,
        otpValidated,
        user,
        currentStep,
        isStepValid,
      ];

  RegisterBlocState copyWith({
    EmailInput? email,
    PasswordInput? password,
    ConfirmedPasswordInput? confirmedPassword,
    OtpCodeInput? otpCode,
    DateTime? birthDate,
    String? errorMessage,
    bool? isLoading,
    bool? formSubmitted,
    RegisterStatus? status,
    bool? otpValidated,
    User? user,
    int? currentStep,
    bool? isStepValid,
  }) {
    return RegisterBlocState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      otpCode: otpCode ?? this.otpCode,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      formSubmitted: formSubmitted ?? this.formSubmitted,
      status: status ?? this.status,
      otpValidated: otpValidated ?? this.otpValidated,
      user: user ?? this.user,
      currentStep: currentStep ?? this.currentStep,
      isStepValid: isStepValid ?? this.isStepValid,
    );
  }
}

enum RegisterStatus {
  initial,
  inProgress,
  success,
  failure,
}

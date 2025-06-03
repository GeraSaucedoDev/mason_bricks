part of 'login_bloc.dart';

class LoginBlocState {
  final String errorMessage;
  final bool isLoading;
  final User? user;
  final EmailInput email;
  final PasswordInput password;
  final FormzSubmissionStatus status;
  final bool formSubmitted;

  const LoginBlocState({
    this.errorMessage = '',
    this.isLoading = false,
    this.user,
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.formSubmitted = false,
  });

  List<Object?> get props => [
        errorMessage,
        isLoading,
        user,
        email,
        password,
        status,
        formSubmitted,
      ];

  LoginBlocState copyWith({
    String? errorMessage,
    bool? isLoading,
    User? user,
    EmailInput? email,
    PasswordInput? password,
    FormzSubmissionStatus? status,
    bool? formSubmitted,
  }) {
    return LoginBlocState(
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      formSubmitted: formSubmitted ?? this.formSubmitted,
    );
  }
}

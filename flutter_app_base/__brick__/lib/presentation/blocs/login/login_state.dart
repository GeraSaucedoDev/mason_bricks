part of 'login_bloc.dart';

class LoginBlocState {
  final String errorMessage;
  final bool isLoading;
  final User? user;
  final EmailInput email;
  final PasswordInput password;
  // handle when show error messages on textfields
  final bool formSubmitted;
  // Handle success login method
  final bool successLogin;

  const LoginBlocState({
    this.errorMessage = '',
    this.isLoading = false,
    this.user,
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.formSubmitted = false,
    this.successLogin = false,
  });

  List<Object?> get props => [
        errorMessage,
        isLoading,
        user,
        email,
        password,
        formSubmitted,
        successLogin,
      ];

  LoginBlocState copyWith({
    String? errorMessage,
    bool? isLoading,
    User? user,
    EmailInput? email,
    PasswordInput? password,
    bool? formSubmitted,
    bool? successLogin,
  }) {
    return LoginBlocState(
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      email: email ?? this.email,
      password: password ?? this.password,
      formSubmitted: formSubmitted ?? this.formSubmitted,
      successLogin: successLogin ?? this.successLogin,
    );
  }
}

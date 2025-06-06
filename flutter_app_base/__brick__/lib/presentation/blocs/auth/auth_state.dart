part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final String errorMessage;
  final bool isLoading;
  final User? user;
  final bool? isFederated;
  final String arnAWS;

  const AuthState({
    this.authStatus = AuthStatus.unknown,
    this.errorMessage = '',
    this.isLoading = false,
    this.user,
    this.isFederated,
    this.arnAWS = '',
  });

  @override
  List<Object?> get props =>
      [authStatus, errorMessage, isLoading, user, isFederated, arnAWS];

  AuthState copyWith(
      {AuthStatus? authStatus,
      String? errorMessage,
      bool? isLoading,
      User? user,
      bool? isFederated,
      String? arnAWS}) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      isFederated: isFederated ?? this.isFederated,
      arnAWS: arnAWS ?? this.arnAWS,
    );
  }
}

enum AuthStatus {
  unknown,
  authenticated,
  notAuthenticated,
  notCompleted,
  completed,
  noMembership
}

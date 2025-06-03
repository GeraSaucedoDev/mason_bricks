part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class ChangeAuthStatus extends AuthEvent {
  const ChangeAuthStatus(this.authStatus);

  final AuthStatus authStatus;

  @override
  List<Object?> get props => [authStatus];
}

class ChangeAuthUser extends AuthEvent {
  const ChangeAuthUser(this.user);

  final User user;

  @override
  List<Object?> get props => [user];
}

class LogoutRequested extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

class CleanAuthError extends AuthEvent {}

class SubscribeTokenDevice extends AuthEvent {
  const SubscribeTokenDevice(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class GetAppConfig extends AppEvent {}

class CleanState extends AppEvent {}

class CleanError extends AppEvent {}

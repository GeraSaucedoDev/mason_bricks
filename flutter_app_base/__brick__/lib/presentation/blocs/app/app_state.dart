part of 'app_bloc.dart';

class AppState extends Equatable {
  final String errorMessage;
  final bool isLoading;
  final bool dataLoaded;

  const AppState({
    this.errorMessage = '',
    this.isLoading = false,
    this.dataLoaded = false,
  });

  @override
  List<Object?> get props => [errorMessage, isLoading, dataLoaded];

  AppState copyWith({String? errorMessage, bool? isLoading, bool? dataLoaded}) {
    return AppState(
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      dataLoaded: dataLoaded ?? this.dataLoaded,
    );
  }
}

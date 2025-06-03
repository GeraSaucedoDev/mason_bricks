import 'dart:developer';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{app_name}}/core/services/logger/app_logger.dart';
import 'package:{{app_name}}/data/repositories/{{plural_name.snakeCase()}}_repository.dart';
import 'package:{{app_name}}/domain/models/{{model_name.snakeCase()}}.dart';
import 'package:{{app_name}}/presentation/blocs/bloc_transforms.dart';

part '{{plural_name.snakeCase()}}_events.dart';
part '{{plural_name.snakeCase()}}_state.dart';

class {{plural_name.pascalCase()}}Bloc extends Bloc<{{plural_name.pascalCase()}}Event, {{plural_name.pascalCase()}}State> {
  {{plural_name.pascalCase()}}Bloc({required {{plural_name.pascalCase()}}Repository {{plural_name.camelCase()}}Repository})
    : _{{plural_name.camelCase()}}Repository = {{plural_name.camelCase()}}Repository,
      // Bloc events
      super(const {{plural_name.pascalCase()}}State()) {
    
    on<{{plural_name.pascalCase()}}StateCleaned>(_on{{plural_name.pascalCase()}}StateCleaned);
    on<{{model_name.pascalCase()}}Added>(_on{{model_name.pascalCase()}}Added);
    on<{{model_name.pascalCase()}}Removed>(_on{{model_name.pascalCase()}}Removed);
    on<{{model_name.pascalCase()}}Updated>(_on{{model_name.pascalCase()}}Updated);

    on<{{plural_name.pascalCase()}}Fetched>(
      _on{{plural_name.pascalCase()}}Fetched,  
      transformer: restartable<{{plural_name.pascalCase()}}Fetched>(),
    );

    on<SearchQueryChanged>(
      _onSearchQueryChanged,
      transformer: debounceRestartable<SearchQueryChanged>(
        Duration(
          milliseconds: 500,
        ),
      ),
    );
  }

  final {{plural_name.pascalCase()}}Repository _{{plural_name.camelCase()}}Repository;

  void _on{{plural_name.pascalCase()}}Fetched({{plural_name.pascalCase()}}Fetched event, Emitter<{{plural_name.pascalCase()}}State> emit) async {
    try {
      emit(state.copyWith(
        isLoadingMore: true,
        errorMessage: '',
      ));

      final {{plural_name.camelCase()}} = await _{{plural_name.camelCase()}}Repository.get{{plural_name.pascalCase()}}(
        query: state.searchQuery,
        page: state.currentPage,
        limit: state.itemsPerPage,
      );

      emit(
        state.copyWith(
          isLoadingMore: false,
          {{plural_name.camelCase()}}: [...state. {{plural_name.camelCase()}}, ... {{plural_name.camelCase()}}],
          currentPage: state.currentPage + 1,
          hasReachedMax: {{plural_name.camelCase()}}.length < state.itemsPerPage,
        ),
      );
    } catch (e, stack) {
      AppLogger.e('$runtimeType | _on{{plural_name.pascalCase()}}Fetched()', e, stack);
      emit(
        state.copyWith(
          isLoadingMore: false,
          errorMessage: '{{plural_name.constantCase()}}_FETCH_ERROR',
        ),
      );
    }
  }


  void _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<{{plural_name.pascalCase()}}State> emit,
  ) {
    log('Evento search query lanzado: ${event.query}');
    final trimmedQuery = event.query.trim();

    // update query  only if changed
    if (trimmedQuery == state.searchQuery) return;

    emit(state.copyWith(
      searchQuery: trimmedQuery,
      {{plural_name.camelCase()}}: [],
      currentPage: 1, // Initial page
      hasReachedMax: false,
    ));
    add({{plural_name.pascalCase()}}Fetched());
  }

  void _on{{model_name.pascalCase()}}Added({{model_name.pascalCase()}}Added event, Emitter<{{plural_name.pascalCase()}}State> emit) {
    final updated{{plural_name.pascalCase()}} = [event.{{model_name.camelCase()}}, ...state.{{plural_name.camelCase()}}];

    emit(state.copyWith({{plural_name.camelCase()}}: updated{{plural_name.pascalCase()}}));
  }

  void _on{{model_name.pascalCase()}}Removed({{model_name.pascalCase()}}Removed event, Emitter<{{plural_name.pascalCase()}}State> emit) {
    final updated{{plural_name.pascalCase()}} = state.{{plural_name.camelCase()}}
        .where(({{model_name.camelCase()}}) => event.{{model_name.camelCase()}}.id != {{model_name.camelCase()}}.id)
        .toList();

    emit(state.copyWith({{plural_name.camelCase()}}: updated{{plural_name.pascalCase()}}));
  }

  void _on{{model_name.pascalCase()}}Updated({{model_name.pascalCase()}}Updated event, Emitter<{{plural_name.pascalCase()}}State> emit) {
    final updated{{plural_name.pascalCase()}} = state.{{plural_name.camelCase()}}.map(({{model_name.camelCase()}}) {
      if ({{model_name.camelCase()}}.id == event.{{model_name.camelCase()}}.id) {
        return event.{{model_name.camelCase()}};
      }
      return {{model_name.camelCase()}};
    }).toList();

    emit(state.copyWith({{plural_name.camelCase()}}: updated{{plural_name.pascalCase()}}));
  }

  void _on{{plural_name.pascalCase()}}StateCleaned({{plural_name.pascalCase()}}StateCleaned event, Emitter<{{plural_name.pascalCase()}}State> emit) {
    emit(const {{plural_name.pascalCase()}}State());
  }
}

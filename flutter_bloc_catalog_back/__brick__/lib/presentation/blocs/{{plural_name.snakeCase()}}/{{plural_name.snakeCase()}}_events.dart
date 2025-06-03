part of '{{plural_name.snakeCase()}}_bloc.dart';

sealed class {{plural_name.pascalCase()}}Event extends Equatable {
  const {{plural_name.pascalCase()}}Event();
  @override
  List<Object?> get props => [];
}

final class {{plural_name.pascalCase()}}Fetched extends {{plural_name.pascalCase()}}Event {
  const {{plural_name.pascalCase()}}Fetched();
}

final class More{{plural_name.pascalCase()}}Loaded extends {{plural_name.pascalCase()}}Event {
  const More{{plural_name.pascalCase()}}Loaded();
}

final class SearchQueryChanged extends {{plural_name.pascalCase()}}Event {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

final class {{plural_name.pascalCase()}}StateCleaned extends {{plural_name.pascalCase()}}Event {
  const {{plural_name.pascalCase()}}StateCleaned();
}

final class {{model_name.pascalCase()}}Added extends {{plural_name.pascalCase()}}Event {
  final {{model_name.pascalCase()}} {{model_name.camelCase()}};

  const {{model_name.pascalCase()}}Added(this.{{model_name.camelCase()}});

  @override
  List<Object?> get props => [{{model_name.camelCase()}}];
}

final class {{model_name.pascalCase()}}Removed extends {{plural_name.pascalCase()}}Event {
  final {{model_name.pascalCase()}} {{model_name.camelCase()}};

  const {{model_name.pascalCase()}}Removed(this.{{model_name.camelCase()}});

  @override
  List<Object?> get props => [{{model_name.camelCase()}}];
}

final class {{model_name.pascalCase()}}Updated extends {{plural_name.pascalCase()}}Event {
  final {{model_name.pascalCase()}} {{model_name.camelCase()}};

  const {{model_name.pascalCase()}}Updated(this.{{model_name.camelCase()}});

  @override
  List<Object?> get props => [{{model_name.camelCase()}}];
}

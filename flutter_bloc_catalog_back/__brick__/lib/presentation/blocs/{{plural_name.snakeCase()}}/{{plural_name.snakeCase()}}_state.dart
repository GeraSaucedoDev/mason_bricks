part of '{{plural_name.snakeCase()}}_bloc.dart';

enum {{plural_name.pascalCase()}}Status { initial, loading, success, failure }

final class {{plural_name.pascalCase()}}State extends Equatable {
  const {{plural_name.pascalCase()}}State({
    this.status = {{plural_name.pascalCase()}}Status.initial,
    this.{{plural_name.camelCase()}} = const <{{model_name.pascalCase()}}>[],
    this.hasReachedMax = false,
    this.errorMessage = '',
    // TODO UPDATE INITIAL PAGE INDEX
    this.currentPage = 0,
    this.itemsPerPage = 10,
    this.searchQuery = '',
    this.isLoadingMore = false,
  });

  final {{plural_name.pascalCase()}}Status status;
  final List<{{model_name.pascalCase()}}> {{plural_name.camelCase()}};
  final bool hasReachedMax;
  final String errorMessage;
  final int currentPage;
  final int itemsPerPage;
  final String searchQuery;
  final bool isLoadingMore;

  {{plural_name.pascalCase()}}State copyWith({
    {{plural_name.pascalCase()}}Status? status,
    List<{{model_name.pascalCase()}}>? {{plural_name.camelCase()}},
    bool? hasReachedMax,
    String? errorMessage,
    int? currentPage,
    int? itemsPerPage,
    String? searchQuery,
    bool? isLoadingMore,
  }) {
    return {{plural_name.pascalCase()}}State(
      status: status ?? this.status,
      {{plural_name.camelCase()}}: {{plural_name.camelCase()}} ?? this.{{plural_name.camelCase()}},
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
    );
  }

  @override
  String toString() {
    return '''{{plural_name.pascalCase()}}State { 
      status: $status, 
      hasReachedMax: $hasReachedMax, 
      {{plural_name.camelCase()}}: ${{{plural_name.camelCase()}}.length},
      currentPage: $currentPage,
      itemsPerPage: $itemsPerPage,
      searchQuery: "$searchQuery",
      errorMessage: "$errorMessage",
      isLoadingMore: $isLoadingMore
    }''';
  }

  @override
  List<Object> get props => [
    status,
    {{plural_name.camelCase()}},
    hasReachedMax,
    errorMessage,
    currentPage,
    itemsPerPage,
    searchQuery,
    isLoadingMore,
  ];
}

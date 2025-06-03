import 'package:flutter/material.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

class AppInfiniteList extends StatelessWidget {
  const AppInfiniteList({
    super.key,
    required this.itemCount,
    this.hasReachedMax = false,
    this.isLoading = false,
    this.hasError = false,
    required this.itemBuilder,
    required this.onFetchData,
    this.loadingBuilder,
    this.errorBuilder,
    this.emptyBuilder,
  });

  final int itemCount;
  final bool hasReachedMax;
  final bool isLoading;
  final bool hasError;
  final Widget Function(BuildContext, int) itemBuilder;
  final VoidCallback onFetchData;
  final Widget Function(BuildContext)? loadingBuilder;
  final Widget Function(BuildContext)? errorBuilder;
  final Widget Function(BuildContext)? emptyBuilder;

  @override
  Widget build(BuildContext context) {
    return InfiniteList(
      itemCount: itemCount,
      hasReachedMax: hasReachedMax,
      isLoading: isLoading,
      hasError: hasError,
      itemBuilder: itemBuilder,
      onFetchData: onFetchData,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      emptyBuilder: emptyBuilder,
      debounceDuration: Duration(milliseconds: 0),
      centerEmpty: true,
      centerError: true,
      centerLoading: true,
    );
  }
}

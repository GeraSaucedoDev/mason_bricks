import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{app_name}}/presentation/blocs/{{plural_name.snakeCase()}}/{{plural_name.snakeCase()}}_bloc.dart';
import 'package:{{app_name}}/presentation/screens/{{plural_name.snakeCase()}}/views/{{plural_name.snakeCase()}}_empty_view.dart';
import 'package:{{app_name}}/presentation/screens/{{plural_name.snakeCase()}}/views/{{plural_name.snakeCase()}}_error_view.dart';
import 'package:{{app_name}}/presentation/screens/{{plural_name.snakeCase()}}/widgets/{{model_name.snakeCase()}}_tile.dart';
import 'package:{{app_name}}/presentation/widgets/utils/app_infinite_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class {{plural_name.pascalCase()}}View extends StatelessWidget {
  const {{plural_name.pascalCase()}}View({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 24),
        TextField(
          onChanged: (value) {
            if (value.length < 3 && value.isNotEmpty) {
              // TODO SHOW APPBAR INFO
              log('Evento no lo suficientemente largo para trigger: $value');
              return;
            }
            context.read<{{plural_name.pascalCase()}}Bloc>().add(SearchQueryChanged(value));
          },
        ),
        SizedBox(height: 1.h),
        Expanded(
          child: BlocBuilder<{{plural_name.pascalCase()}}Bloc, {{plural_name.pascalCase()}}State>(
            builder: (context, state) {
              return AppInfiniteList(
                itemCount: state.{{plural_name.camelCase()}}.length,
                hasReachedMax: state.hasReachedMax,
                isLoading: state.isLoadingMore,
                hasError: state.errorMessage != '',
                itemBuilder: (context, index) {
                  return {{model_name.pascalCase()}}Tile(item: state.{{plural_name.camelCase()}}[index]);
                },
                onFetchData: () {
                  context.read<{{plural_name.pascalCase()}}Bloc>().add({{plural_name.pascalCase()}}Fetched());
                },
                loadingBuilder: (context) => state.{{plural_name.camelCase()}}.isEmpty
                    ? CircularProgressIndicator()
                    : LinearProgressIndicator(),
                errorBuilder: (context) => {{plural_name.pascalCase()}}ErrorView(),
                emptyBuilder: (context) => {{plural_name.pascalCase()}}EmptyView(),
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{app_name}}/presentation/blocs/{{plural_name.snakeCase()}}/{{plural_name.snakeCase()}}_bloc.dart';
import 'package:{{app_name}}/presentation/screens/{{plural_name.snakeCase()}}/{{plural_name.snakeCase()}}_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class {{plural_name.pascalCase()}}Screen extends StatelessWidget {
  const {{plural_name.pascalCase()}}Screen({super.key});

  static const String route = '{{plural_name.paramCase()}}';
  static const String name = '{{plural_name.paramCase()}}-screen';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          context.read<{{plural_name.pascalCase()}}Bloc>().add({{plural_name.pascalCase()}}StateCleaned());
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: {{plural_name.pascalCase()}}View(),
        ),
      ),
    );
  }
}

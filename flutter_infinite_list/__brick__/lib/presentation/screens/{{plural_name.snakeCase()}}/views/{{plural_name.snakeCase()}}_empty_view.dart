import 'package:flutter/material.dart';
import 'package:{{app_name}}/presentation/widgets/views/empty_view.dart';

class {{plural_name.pascalCase()}}EmptyView extends StatelessWidget {
  const {{plural_name.pascalCase()}}EmptyView({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return EmptyView(message: message);
  }
}

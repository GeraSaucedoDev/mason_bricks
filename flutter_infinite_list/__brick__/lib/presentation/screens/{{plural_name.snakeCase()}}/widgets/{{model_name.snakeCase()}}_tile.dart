import 'package:flutter/material.dart';
import 'package:{{app_name}}/core/theme/extensions/theme_extensions.dart';
import 'package:{{app_name}}/domain/models/{{model_name.snakeCase()}}.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class {{model_name.pascalCase()}}Tile extends StatelessWidget {
  const {{model_name.pascalCase()}}Tile({super.key, required this.item});

  final {{model_name.pascalCase()}} item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.5.h),
      child: Card(
        color: context.colorScheme.primaryContainer,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('${item.id} - Property')],
          ),
        ),
      ),
    );
  }
}

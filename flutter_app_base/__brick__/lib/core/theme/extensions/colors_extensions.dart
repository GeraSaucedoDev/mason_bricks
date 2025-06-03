import 'package:flutter/material.dart';
import 'package:{{app_name}}/core/theme/app_colors.dart';

extension ColorsExtension on BuildContext {
  // access container extension
  ColorDataExtension get colors => ColorDataExtension(this);
}

class ColorDataExtension {
  final BuildContext context;

  ColorDataExtension(this.context);

  Color get container01 {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.container01Dark
        : AppColors.container01Light;
  }

  Color get container02 {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.container02Dark
        : AppColors.container02Light;
  }

  Color get container03 {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.container03Dark
        : AppColors.container03Light;
  }

  Color get container04 {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.container04Dark
        : AppColors.container04Light;
  }
}

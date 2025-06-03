import 'package:flutter/material.dart';
import 'package:{{app_name}}/core/theme/fonts/roboto.dart';

class TextStyles {
  final roboto = Roboto.instance;
  // final poppins = Poppins.instance;
}

extension TextStyleExtension on BuildContext {
  TextStyles get textstyles => TextStyles();
}

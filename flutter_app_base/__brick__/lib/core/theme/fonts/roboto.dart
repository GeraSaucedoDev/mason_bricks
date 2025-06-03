import 'package:flutter/material.dart';

class Roboto {
  static final instance = Roboto._();
  Roboto._();

  final TextStyle h1Black = const TextStyle(
    fontFamily: 'Roboto',
    fontSize: 32,
    fontWeight: FontWeight.w900,
  );

  final TextStyle h1Medium = const TextStyle(
    fontFamily: 'Roboto',
    fontSize: 32,
    fontWeight: FontWeight.w500,
  );

  final TextStyle h3Medium = const TextStyle(
    fontFamily: 'Roboto',
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );
}
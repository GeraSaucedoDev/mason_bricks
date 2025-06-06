import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Poppins {
  Poppins._();
  static final Poppins instance = Poppins._();

  static const String _fontFamily = 'poppins';

  TextStyle get dLarge => TextStyle(
        fontSize: 15.sp,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w900,
      );

  TextStyle get dMed => TextStyle(
        fontSize: 22.sp,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w900,
      );

  TextStyle get dSmall => TextStyle(
        fontSize: 18.5.sp, //24
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w600,
      );

  TextStyle get hLarge => TextStyle(
        fontSize: 18.5.sp,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w500,
      );

  // confirmed
  TextStyle get hMed => TextStyle(
        fontSize: 19.5.sp,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w500,
      );

  TextStyle get hSmall => TextStyle(
        fontSize: 17.5.sp,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w400,
      );

  TextStyle get titleLarge => TextStyle(
        fontSize: 18.sp,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w700,
      );

  TextStyle get titleMed => TextStyle(
        fontSize: 16.sp, //18
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w600,
      );

  TextStyle get titleSmall => TextStyle(
        fontSize: 15.sp,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w800,
      );

  TextStyle get labelLarge => TextStyle(
        fontSize: 15.sp,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w800,
      );

  TextStyle get labelMed => TextStyle(
        fontSize: 13.5.sp, //12
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w500,
      );

  TextStyle get labelSmall => TextStyle(
        fontSize: 14.4.sp,
        fontFamily: _fontFamily,
      );

  TextStyle get bodyLarge => TextStyle(
        fontSize: 15.sp,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w500,
      );

  TextStyle get bodyMed => TextStyle(
        fontSize: 14.4.sp, //14
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w600,
      );

  // Confirmed
  TextStyle get bodySmall => TextStyle(
        fontSize: 13.5.sp, //14
        fontFamily: _fontFamily,
        //fontWeight: FontWeight.w600,
      );
}

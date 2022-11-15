import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles/style_exports.dart';

enum AppTheme{
  lightTheme, darkTheme,
}

class AppThemes {
  static final appThemeData = {
    AppTheme.darkTheme: ThemeData(
    ),

    //
    //

    AppTheme.lightTheme: ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.white,
      brightness: Brightness.light,
      backgroundColor: const Color(0xFFFFFFFF),
      dividerColor: const Color(0xFF737373),
      fontFamily: 'Montserrat',
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme(
        headline4: TextStyle(
          color: Colors.black,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          letterSpacing: 4,
          fontSize: 32,
        ),
        headline5: TextStyle(
          color: Colors.black,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          letterSpacing: 4,
          fontSize: 28,
        ),
        subtitle1: TextStyle(
          color: Colors.white,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w400,
          fontSize: 16,
          letterSpacing: 1
        ),
        subtitle2: TextStyle(
          color: colorGrey,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: 2,
        ),
      ),
    ),
  };
}
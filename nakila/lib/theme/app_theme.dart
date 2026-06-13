import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData lightTheme =
      ThemeData(
    brightness: Brightness.light,

    scaffoldBackgroundColor:
        const Color(0xffF8FAFC),

    primaryColor:
        const Color(0xff2563EB),

    cardColor: Colors.white,
  );

  static ThemeData darkTheme =
      ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor:
        const Color(0xff0F172A),

    primaryColor:
        const Color(0xff3B82F6),

    cardColor:
        const Color(0xff1E293B),
  );
}
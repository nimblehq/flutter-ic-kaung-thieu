import 'package:flutter/material.dart';
import 'package:survey_flutter/gen/fonts.gen.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
      fontFamily: FontFamily.neuzeit,
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 34,
          fontWeight: FontWeight.w800,
        ),
        titleMedium: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.w800,
        ),
        bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
        labelLarge: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
        labelMedium: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w800,
        ),
        labelSmall: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w800,
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
      ));
}

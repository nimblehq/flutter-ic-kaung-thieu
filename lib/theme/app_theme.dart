import 'package:flutter/material.dart';
import 'package:survey_flutter/gen/fonts.gen.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        fontFamily: FontFamily.neuzeit,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
          labelLarge: TextStyle(
              color: Colors.red, fontSize: 17, fontWeight: FontWeight.w800),
        ),
      );
}

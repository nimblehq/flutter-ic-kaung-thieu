import 'package:flutter/material.dart';
import 'package:survey_flutter/theme/constant.dart';

class FormFieldDecoration extends InputDecoration {
  final String hint;
  final TextStyle? hintTextStyle;
  final String? errorString;

  FormFieldDecoration(
      {required this.hint, required this.hintTextStyle, this.errorString})
      : super(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(Metrics.defaultBorderRadius),
          ),
          fillColor: Colors.white24,
          filled: true,
          hintStyle: hintTextStyle?.copyWith(color: Colors.white24),
          hintText: hint,
          errorMaxLines: 2,
          errorText: errorString,
        );
}

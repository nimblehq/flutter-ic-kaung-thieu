import 'package:flutter/material.dart';
import 'package:survey_flutter/theme/constant.dart';

class FormFieldDecoration extends InputDecoration {
  final String hint;
  final TextStyle? hintTextStyle;

  FormFieldDecoration({required this.hint, required this.hintTextStyle})
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
        );
}

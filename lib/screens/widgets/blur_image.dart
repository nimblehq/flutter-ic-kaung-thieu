import 'dart:ui';
import 'package:flutter/material.dart';

class BlurImage extends StatelessWidget {
  final Image image;

  const BlurImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(
        sigmaX: 25,
        sigmaY: 25,
      ),
      child: image,
    );
  }
}

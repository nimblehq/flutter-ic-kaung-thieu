import 'package:flutter/material.dart';

class ShimmerRoundedRectangle extends StatelessWidget {
  final double? _topPadding;
  final double? _bottomPadding;
  final double? _width;
  final double? _leftPadding;
  final double? _rightPadding;

  const ShimmerRoundedRectangle({
    Key? key,
    double? topPadding,
    double? bottomPadding,
    double? leftPadding,
    double? rightPadding,
    required double? width,
  })  : _bottomPadding = bottomPadding,
        _topPadding = topPadding,
        _leftPadding = leftPadding,
        _rightPadding = rightPadding,
        _width = width,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        _leftPadding ?? 0,
        _topPadding ?? 0,
        _rightPadding ?? 0,
        _bottomPadding ?? 0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          color: Colors.black,
        ),
        width: _width,
        height: 20,
      ),
    );
  }
}

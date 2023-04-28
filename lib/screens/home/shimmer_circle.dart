import 'package:flutter/material.dart';

class ShimmerCircle extends StatelessWidget {
  final double? _topPadding;
  final double? _bottomPadding;
  final double _size;
  final double? _leftPadding;
  final double? _rightPadding;

  const ShimmerCircle({
    Key? key,
    double? topPadding,
    double? bottomPadding,
    double? leftPadding,
    double? rightPadding,
    required double size,
  })  : _bottomPadding = bottomPadding,
        _topPadding = topPadding,
        _leftPadding = leftPadding,
        _rightPadding = rightPadding,
        _size = size,
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
        decoration:
            const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
        width: _size,
        height: _size,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:survey_flutter/screens/home/shimmer_circle.dart';
import 'package:survey_flutter/screens/home/shimmer_rounded_rectangle.dart';

class HomeShimmerLoading extends StatelessWidget {
  const HomeShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Shimmer.fromColors(
        baseColor: Colors.white12,
        highlightColor: Colors.white30,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ShimmerRoundedRectangle(
                      topPadding: 61,
                      width: 130,
                      leftPadding: 20,
                    ),
                    ShimmerRoundedRectangle(
                      topPadding: 10,
                      width: 100,
                      leftPadding: 20,
                    ),
                  ],
                ),
                const Spacer(),
                const ShimmerCircle(
                  size: 36,
                  topPadding: 79,
                  rightPadding: 20,
                ),
              ],
            ),
            const Spacer(),
            const ShimmerRoundedRectangle(
              topPadding: 20,
              leftPadding: 20,
              rightPadding: 100,
              width: 40,
            ),
            const ShimmerRoundedRectangle(
              topPadding: 20,
              leftPadding: 20,
              rightPadding: 100,
              width: double.maxFinite,
            ),
            const ShimmerRoundedRectangle(
              topPadding: 10,
              leftPadding: 20,
              rightPadding: 40,
              width: 100,
            ),
            const ShimmerRoundedRectangle(
              topPadding: 20,
              leftPadding: 20,
              rightPadding: 40,
              width: double.maxFinite,
            ),
            const ShimmerRoundedRectangle(
              topPadding: 10,
              bottomPadding: 62,
              leftPadding: 20,
              rightPadding: 20,
              width: 180,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:survey_flutter/screens/home/shimmer_circle.dart';
import 'package:survey_flutter/screens/home/shimmer_rounded_rectangle.dart';

class HomeShimmerLoading extends StatelessWidget {
  const HomeShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Shimmer.fromColors(
      baseColor: Colors.white12,
      highlightColor: Colors.white30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerRoundedRectangle(
                    topPadding: 61,
                    width: screenWidth * 0.35,
                    leftPadding: 20,
                  ),
                  ShimmerRoundedRectangle(
                    topPadding: 10,
                    width: screenWidth * 0.3,
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
          ShimmerRoundedRectangle(
            topPadding: 20,
            leftPadding: 20,
            width: screenWidth * 0.1,
          ),
          ShimmerRoundedRectangle(
            topPadding: 20,
            leftPadding: 20,
            width: screenWidth * 0.65,
          ),
          ShimmerRoundedRectangle(
            topPadding: 10,
            leftPadding: 20,
            width: screenWidth * 0.25,
          ),
          ShimmerRoundedRectangle(
              topPadding: 20, leftPadding: 20, width: screenWidth * 0.8),
          ShimmerRoundedRectangle(
            topPadding: 10,
            bottomPadding: 62,
            leftPadding: 20,
            width: screenWidth * 0.5,
          ),
        ],
      ),
    );
  }
}

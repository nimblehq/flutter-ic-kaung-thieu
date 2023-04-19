import 'package:flutter/material.dart';

import 'home_shimmer_loading.dart';

const routePathHomeScreen = '/home';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO Add home screen UI in part 2
    return const Scaffold(
      backgroundColor: Colors.black,
      body: HomeShimmerLoading(),
    );
  }
}

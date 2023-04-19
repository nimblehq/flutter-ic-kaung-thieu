import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:survey_flutter/gen/assets.gen.dart';

import 'home_shimmer_loading.dart';

const routePathHomeScreen = '/home';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  TextTheme get _textTheme => Theme.of(context).textTheme;

  final _pageController = PageController();
  final int _pageCount = 2;

  bool _isLoading = true;
  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();
    // TODO remove mock duration in integration ticket
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO modify the loading in integration ticket
    if (_isLoading) {
      return const HomeShimmerLoading();
    } else {
      return _buildHomeScreenContent();
    }
  }

  Widget _buildHomeScreenContent() {
    // TODO bind with real data in integrate ticket
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                _selectedPage = page;
              });
            },
            children: [_buildBackgroundImage(), _buildBackgroundImage()],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 60, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Monday, JUNE 15',
                    style: _textTheme.bodyLarge?.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'Today',
                      style: _textTheme.bodyLarge?.copyWith(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 79, 20, 0),
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(18), // Image radius
                  child: Image.network(
                    'https://picsum.photos/376/812',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageViewDotIndicator(
                  currentItem: _selectedPage,
                  count: _pageCount,
                  unselectedColor: Colors.white24,
                  selectedColor: Colors.white,
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment.bottomLeft,
                  size: const Size(8, 8),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 26, 20, 0),
                  child: Text(
                    'Working from home Check-In',
                    maxLines: 2,
                    style: _textTheme.bodyLarge?.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 54),
                        child: Text(
                          'We would like to know how you feel about our work from home. We would like to know how you feel about our work from home. ',
                          maxLines: 2,
                          style: _textTheme.bodyLarge
                              ?.copyWith(color: Colors.white70),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 20, 54),
                      child: FloatingActionButton(
                        onPressed: () {
                          // Add your onPressed code here!
                        },
                        backgroundColor: Colors.white,
                        child: Image.asset(Assets.images.icNavNext.path),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          'https://picsum.photos/376/812',
          fit: BoxFit.cover,
        ),
        Image.asset(
          Assets.images.imageOverlay.path,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}

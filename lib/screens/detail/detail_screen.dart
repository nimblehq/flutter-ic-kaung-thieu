import 'package:flutter/material.dart';
import 'package:survey_flutter/gen/assets.gen.dart';

const routePathDetailScreen = '/home/detail';

class DetailScreen extends StatefulWidget {
  final String surveyId;

  const DetailScreen({required this.surveyId, super.key});

  @override
  State<StatefulWidget> createState() => DetailScreenState();
}

class DetailScreenState extends State<DetailScreen> {
  TextTheme get _textTheme => Theme.of(context).textTheme;
  late PageController _pageController;
  int _selectedPage = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: _selectedPage);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _buildBackgroundImage('https://picsum.photos/376/812'),
        PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (page) {
            setState(() {
              _selectedPage = page;
            });
          },
          children: [
            _buildStartSurveyContent(
              title: 'Working from home Check-In',
              description:
                  'We would like to know how you feel about our work from home (WFH) experience.',
            ),
            _buildSurveyQuestionContent(
                title: 'How fulfilled did you feel during this WFH period?'),
          ],
        ),
      ],
    ));
  }

  Widget _buildSurveyQuestionContent({required String title}) {
    return Column(
      children: [
        _buildToolbar(false),
        Padding(
          padding: const EdgeInsets.only(top: 30.5, left: 20, right: 20),
          child: Text(
            title,
            style: _textTheme.titleLarge,
          ),
        ),
        const Expanded(child: SizedBox.shrink()),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 34, right: 20),
            child: SizedBox(
              width: 56,
              height: 56,
              child: FloatingActionButton(
                onPressed: () {
                  _pageController.animateToPage(
                    _selectedPage + 1,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                  );
                },
                backgroundColor: Colors.white,
                child: Image.asset(Assets.images.icNavNext.path),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStartSurveyContent({
    required String title,
    required String description,
  }) {
    return Column(
      children: [
        _buildToolbar(true),
        Padding(
          padding: const EdgeInsets.only(top: 30.5, left: 20, right: 20),
          child: Text(
            title,
            style: _textTheme.titleLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
          child: Text(
            description,
            style: _textTheme.bodyMedium,
          ),
        ),
        const Expanded(child: SizedBox.shrink()),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 34, right: 20),
            child: SizedBox(
              width: 140,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  _pageController.animateToPage(
                    _selectedPage + 1,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                  );
                },
                child: Text(
                  'Start Survey',
                  style: _textTheme.labelLarge?.copyWith(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToolbar(bool showBack) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (showBack) ...[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 14,
                top: 52,
              ),
              child: IconButton(
                  icon: Image.asset(Assets.images.icBack.path),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ),
          ),
        ] else ...[
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 16,
                top: 52,
              ),
              child: IconButton(
                  icon: Image.asset(Assets.images.icClose.path),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ),
          )
        ]
      ],
    );
  }

  Widget _buildBackgroundImage(String imageUrl) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          imageUrl,
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

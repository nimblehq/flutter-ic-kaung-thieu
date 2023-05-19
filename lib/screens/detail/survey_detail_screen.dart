import 'package:flutter/material.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/screens/detail/survey_question_content.dart';
import 'package:survey_flutter/screens/detail/start_survey_content.dart';

const routePathDetailScreen = '/home/survey_detail';

class SurveyDetailScreen extends StatefulWidget {
  final String surveyId;

  const SurveyDetailScreen({required this.surveyId, super.key});

  @override
  State<StatefulWidget> createState() => SurveyDetailScreenState();
}

class SurveyDetailScreenState extends State<SurveyDetailScreen> {
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
            // TODO replace with data from view model in choice question ticket
            StartSurveyContent(
              title: 'Working from home Check-In',
              description:
                  'We would like to know how you feel about our work from home (WFH) experience.',
              onPressNext: goToNextPage,
            ),
            // TODO replace total page with value from view model in choice question ticket
            SurveyQuestionContent(
              title: 'How fulfilled did you feel during this WFH period?',
              page: _selectedPage,
              totalPage: 5,
              onStartSurvey: goToNextPage,
            ),
          ],
        ),
      ],
    ));
  }

  void goToNextPage() {
    _pageController.animateToPage(
      _selectedPage + 1,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
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

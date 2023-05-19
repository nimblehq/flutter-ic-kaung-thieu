import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/screens/detail/multiple_choice_answers.dart';
import 'package:survey_flutter/screens/detail/survey_question_content.dart';
import 'package:survey_flutter/screens/detail/start_survey_content.dart';
import 'package:survey_flutter/model/survey_question_model.dart';
import 'package:survey_flutter/screens/detail/detail_view_model.dart';

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

  final _surveyDetailStreamProvider = StreamProvider.autoDispose(
      (ref) => ref.watch(detailViewModelProvider.notifier).surveyDetail);

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
      body: Consumer(builder: (context, widgetRef, child) {
        var surveyDetail = widgetRef.watch(_surveyDetailStreamProvider).value;

        if (surveyDetail == null) {
          return Container(
            decoration: const BoxDecoration(color: Colors.black),
            constraints: const BoxConstraints.expand(),
            child: Stack(
              children: const [
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            ),
          );
        } else {
          return Stack(
            children: [
              _buildBackgroundImage(surveyDetail.coverImageUrl),
              PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    _selectedPage = page;
                  });
                },
                children: [
                  StartSurveyContent(
                    title: surveyDetail.title,
                    description: surveyDetail.description,
                    onStartSurvey: goToNextPage,
                  ),
                  for (SurveyQuestionModel question
                      in surveyDetail.questions) ...[
                    SurveyQuestionContent(
                      title: question.title,
                      page: _selectedPage,
                      totalPage: surveyDetail.questions.length,
                      onPressNext: goToNextPage,
                      child: _getQuestionContentChild(question),
                    ),
                  ]
                ],
              ),
            ],
          );
        }
      }),
    );
  }

  Widget _getQuestionContentChild(SurveyQuestionModel question) {
    return Consumer(builder: (_, widgetRef, child) {
      switch (question.displayType) {
        case DisplayType.choice:
          return MultipleChoiceAnswers(
            answers: question.answers,
            onChoiceClick: (answerId) {
              widgetRef
                  .read(detailViewModelProvider.notifier)
                  .updateChoiceAnswer(
                    questionId: question.id,
                    answerId: answerId,
                    pickType: question.pick,
                  );
            },
          );
        default:
          return const Expanded(child: SizedBox.shrink());
      }
    });
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

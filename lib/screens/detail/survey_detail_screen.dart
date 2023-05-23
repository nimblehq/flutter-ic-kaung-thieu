// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/screens/detail/multiple_choice_answers.dart';
import 'package:survey_flutter/screens/detail/success_submit_content.dart';
import 'package:survey_flutter/screens/detail/survey_question_content.dart';
import 'package:survey_flutter/screens/detail/start_survey_content.dart';
import 'package:survey_flutter/model/survey_question_model.dart';
import 'package:survey_flutter/screens/detail/survey_detail_view_model.dart';
import 'package:survey_flutter/screens/detail/text_area_answer.dart';

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
      (ref) => ref.watch(surveyDetailViewModelProvider.notifier).surveyDetail);
  final _isSubmitSuccessStreamProvider = StreamProvider.autoDispose((ref) =>
      ref.watch(surveyDetailViewModelProvider.notifier).isSubmitSuccess);

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
        var isSubmitSurveySuccess =
            widgetRef.watch(_isSubmitSuccessStreamProvider).value;

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
        } else if (isSubmitSurveySuccess ?? false) {
          return SurveySubmitSuccessScreen(
            onAnimationEnd: () {
              context.pop();
            },
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
                      title: question.text,
                      page: _selectedPage,
                      totalPage: surveyDetail.questions.length,
                      onPressNext: () {
                        if (_selectedPage == surveyDetail.questions.length) {
                          widgetRef
                              .read(surveyDetailViewModelProvider.notifier)
                              .submitSurvey();
                        } else {
                          goToNextPage();
                        }
                      },
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
                  .read(surveyDetailViewModelProvider.notifier)
                  .updateChoiceAnswer(
                    questionId: question.id,
                    answerId: answerId,
                    pickType: question.pick,
                  );
            },
          );
        case DisplayType.textArea:
          return TextAreaAnswer(
            answer: question.answers.firstOrNull,
            hint: question.shortText,
            onTextChange: (text) {
              widgetRef
                  .read(surveyDetailViewModelProvider.notifier)
                  .updateTextAnswer(
                      questionId: question.id,
                      answerId: question.answers.firstOrNull?.id ?? '',
                      answerText: text);
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

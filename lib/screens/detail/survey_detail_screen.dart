// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/screens/detail/emoticon_choice_answers.dart';
import 'package:survey_flutter/screens/detail/multiple_choice_answers.dart';
import 'package:survey_flutter/screens/detail/picker_answers.dart';
import 'package:survey_flutter/screens/detail/success_submit_content.dart';
import 'package:survey_flutter/screens/detail/nps_answer.dart';
import 'package:survey_flutter/screens/detail/survey_intro_outro_content.dart';
import 'package:survey_flutter/screens/detail/survey_question_content.dart';
import 'package:survey_flutter/screens/detail/start_survey_content.dart';
import 'package:survey_flutter/model/survey_question_model.dart';
import 'package:survey_flutter/screens/detail/survey_detail_view_model.dart';
import 'package:survey_flutter/screens/detail/text_area_answer.dart';
import 'package:survey_flutter/screens/detail/text_field_answer.dart';
import 'package:survey_flutter/screens/widgets/alert_dialog.dart';

const routePathDetailScreen = '/home/survey_detail';

class SurveyDetailScreen extends ConsumerStatefulWidget {
  final String surveyId;

  const SurveyDetailScreen({required this.surveyId, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      SurveyDetailScreenState();
}

class SurveyDetailScreenState extends ConsumerState<SurveyDetailScreen> {
  AppLocalizations get _localizations => AppLocalizations.of(context)!;

  late PageController _pageController;
  int _selectedPage = 0;

  final _surveyDetailStreamProvider = StreamProvider.autoDispose(
      (ref) => ref.watch(surveyDetailViewModelProvider.notifier).surveyDetail);
  final _isSubmitSuccessStreamProvider = StreamProvider.autoDispose((ref) =>
      ref.watch(surveyDetailViewModelProvider.notifier).isSubmitSuccess);
  final _isErrorStreamProvider = StreamProvider.autoDispose(
      (ref) => ref.watch(surveyDetailViewModelProvider.notifier).isError);

  @override
  void initState() {
    ref
        .read(surveyDetailViewModelProvider.notifier)
        .getSurveyDetail(widget.surveyId);
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
    ref.listen<AsyncValue<String>>(_isErrorStreamProvider, (previous, next) {
      final error = next.value ?? '';
      if (error.isNotEmpty) {
        WidgetsBinding.instance
            .addPostFrameCallback((_) => createSnackBar(error));
        ref.read(surveyDetailViewModelProvider.notifier).clearError();
      }
    });

    ref.listen<AsyncValue<bool>>(_isSubmitSuccessStreamProvider,
        (previous, next) {
      final isSuccess = next.value ?? false;
      if (!isSuccess) {
        showAlertDialog(
            context: context,
            title: _localizations.surveySubmitErrorTitle,
            message: _localizations.surveySubmitErrorMsg,
            actions: [
              TextButton(
                child: Text(_localizations.okText),
                onPressed: () => Navigator.pop(context),
              ),
            ]);
      }
    });

    return Scaffold(
      body: Consumer(builder: (context, widgetRef, child) {
        var surveyDetail = widgetRef.watch(_surveyDetailStreamProvider).value;
        var isSubmitSurveySuccess =
            widgetRef.watch(_isSubmitSuccessStreamProvider).value;

        void onPressNext() {
          FocusManager.instance.primaryFocus?.unfocus();
          if (_selectedPage == surveyDetail?.questions.length) {
            widgetRef
                .read(surveyDetailViewModelProvider.notifier)
                .submitSurvey(widget.surveyId);
          } else {
            goToNextPage();
          }
        }

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
                    (question.displayType == DisplayType.intro ||
                            question.displayType == DisplayType.outro)
                        ? SurveyIntroOutroContent(
                            title: question.text,
                            page: _selectedPage,
                            totalPage: surveyDetail.questions.length,
                            onPressNext: onPressNext)
                        : SurveyQuestionContent(
                            title: question.text,
                            page: _selectedPage,
                            totalPage: surveyDetail.questions.length,
                            onPressNext: onPressNext,
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

  void createSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
        case DisplayType.textField:
          return TextFieldAnswer(
              answers: question.answers,
              onTextChange: (answerId, text) {
                widgetRef
                    .read(surveyDetailViewModelProvider.notifier)
                    .updateTextAnswer(
                        questionId: question.id,
                        answerId: answerId,
                        answerText: text);
              });
        case DisplayType.nps:
          return NpsAnswer(
              onChoiceClick: (answerId) {
                widgetRef
                    .read(surveyDetailViewModelProvider.notifier)
                    .updateChoiceAnswer(
                      questionId: question.id,
                      answerId: answerId,
                      pickType: PickType.one,
                    );
              },
              answers: question.answers);
        case DisplayType.smiley:
        case DisplayType.thumbs:
        case DisplayType.heart:
        case DisplayType.star:
          return EmoticonChoiceAnswers(
            onChoiceClick: (answerId) {
              widgetRef
                  .read(surveyDetailViewModelProvider.notifier)
                  .updateChoiceAnswer(
                    questionId: question.id,
                    answerId: answerId,
                    pickType: question.pick,
                  );
            },
            answers: question.answers,
            displayType: question.displayType,
          );
        case DisplayType.dropdown:
          return PickerAnswers(
              answers: question.answers,
              onChoiceClick: (answerId) {
                widgetRef
                    .read(surveyDetailViewModelProvider.notifier)
                    .updateChoiceAnswer(
                      questionId: question.id,
                      answerId: answerId,
                      pickType: question.pick,
                    );
              });
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

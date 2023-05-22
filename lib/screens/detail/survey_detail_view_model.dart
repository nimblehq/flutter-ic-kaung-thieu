import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/model/survey_answer_model.dart';
import 'package:survey_flutter/model/survey_detail_model.dart';
import 'package:survey_flutter/model/survey_question_model.dart';

final surveyDetailViewModelProvider =
    AsyncNotifierProvider.autoDispose<SurveyDetailViewModel, void>(
        SurveyDetailViewModel.new);

class SurveyDetailViewModel extends AutoDisposeAsyncNotifier<void> {
  SurveyDetailModel? _cache;

  final _surveyDetail = StreamController<SurveyDetailModel>();
  Stream<SurveyDetailModel> get surveyDetail => _surveyDetail.stream;

  final _isSubmitSuccess = StreamController<bool>();
  Stream<bool> get isSubmitSuccess => _isSubmitSuccess.stream;

  @override
  FutureOr<void> build() {
    fetchMockDetail();
    ref.onDispose(() {
      _surveyDetail.close();
    });
  }

  void submitSurvey() {
    _isSubmitSuccess.add(true);
  }

  void updateChoiceAnswer({
    required String questionId,
    required String answerId,
    required PickType pickType,
  }) {
    if (_cache != null) {
      for (var question in _cache!.questions) {
        if (question.id == questionId) {
          for (var answer in question.answers) {
            if (answer.id == answerId) {
              if (pickType == PickType.any) {
                answer.isAnswer = !answer.isAnswer;
              } else if (pickType == PickType.one) {
                answer.isAnswer = true;
              }
            } else if (pickType == PickType.one) {
              answer.isAnswer = false;
            }
          }
        }
      }
      _surveyDetail.add(_cache!);
    }
  }

  void updateTextAnswer({
    required String questionId,
    required String answerId,
    required String answerText,
  }) {
    if (_cache != null) {
      for (var question in _cache!.questions) {
        if (question.id == questionId) {
          for (var answer in question.answers) {
            if (answer.id == answerId) {
              answer.isAnswer = true;
              answer.textAnswer = answerText;
            }
          }
        }
      }
      _surveyDetail.add(_cache!);
    }
  }

  Future<void> fetchMockDetail() async {
    final detail = SurveyDetailModel(
      id: 'id',
      title: 'Working from home Check-In',
      description:
          'We would like to know how you feel about our work from home (WFH) experience.',
      coverImageUrl: 'https://picsum.photos/376/812',
      questions: [
        SurveyQuestionModel(
            id: '1',
            text: 'Question Multi Choice',
            shortText: '',
            pick: PickType.one,
            displayType: DisplayType.choice,
            answers: [
              SurveyAnswerModel(id: '1', text: 'Choice 1'),
              SurveyAnswerModel(id: '2', text: 'Choice 2'),
              SurveyAnswerModel(id: '3', text: 'Choice 3'),
              SurveyAnswerModel(id: '4', text: 'Choice 4'),
              SurveyAnswerModel(id: '5', text: 'Choice 5'),
              SurveyAnswerModel(id: '6', text: 'Choice 6'),
            ]),
        SurveyQuestionModel(
            id: '2',
            text: 'Question Multi Choice',
            shortText: '',
            pick: PickType.any,
            displayType: DisplayType.choice,
            answers: [
              SurveyAnswerModel(id: '1', text: 'Choice 1'),
              SurveyAnswerModel(id: '2', text: 'Choice 2'),
              SurveyAnswerModel(id: '3', text: 'Choice 3'),
            ]),
        SurveyQuestionModel(
            id: '3',
            text: 'Question Nps',
            shortText: '',
            pick: PickType.one,
            displayType: DisplayType.nps,
            answers: [
              SurveyAnswerModel(id: '1', text: '1'),
              SurveyAnswerModel(id: '2', text: '2'),
              SurveyAnswerModel(id: '3', text: '3'),
              SurveyAnswerModel(id: '4', text: '4'),
              SurveyAnswerModel(id: '5', text: '5'),
              SurveyAnswerModel(id: '6', text: '6'),
              SurveyAnswerModel(id: '7', text: '7'),
              SurveyAnswerModel(id: '8', text: '8'),
              SurveyAnswerModel(id: '9', text: '9'),
              SurveyAnswerModel(id: '10', text: '10'),
            ]),
        SurveyQuestionModel(
            id: '4',
            text: 'How did WFH change your productivity?',
            shortText: '',
            pick: PickType.one,
            displayType: DisplayType.smiley,
            answers: [
              SurveyAnswerModel(id: '1', text: '1'),
              SurveyAnswerModel(id: '2', text: '2'),
              SurveyAnswerModel(id: '3', text: '3'),
              SurveyAnswerModel(id: '4', text: '4'),
              SurveyAnswerModel(id: '5', text: '5'),
            ]),
        SurveyQuestionModel(
            id: '5',
            text: 'How did WFH change your productivity?',
            shortText: '',
            pick: PickType.one,
            displayType: DisplayType.heart,
            answers: [
              SurveyAnswerModel(id: '1', text: '1'),
              SurveyAnswerModel(id: '2', text: '2'),
              SurveyAnswerModel(id: '3', text: '3'),
              SurveyAnswerModel(id: '4', text: '4'),
              SurveyAnswerModel(id: '5', text: '5'),
            ]),
        SurveyQuestionModel(
            id: '6',
            text: 'How did WFH change your productivity?',
            shortText: '',
            pick: PickType.one,
            displayType: DisplayType.thumbs,
            answers: [
              SurveyAnswerModel(id: '1', text: '1'),
              SurveyAnswerModel(id: '2', text: '2'),
              SurveyAnswerModel(id: '3', text: '3'),
              SurveyAnswerModel(id: '4', text: '4'),
              SurveyAnswerModel(id: '5', text: '5'),
            ]),
        SurveyQuestionModel(
            id: '7',
            text: 'How did WFH change your productivity?',
            shortText: '',
            pick: PickType.one,
            displayType: DisplayType.star,
            answers: [
              SurveyAnswerModel(id: '1', text: '1'),
              SurveyAnswerModel(id: '2', text: '2'),
              SurveyAnswerModel(id: '3', text: '3'),
              SurveyAnswerModel(id: '4', text: '4'),
              SurveyAnswerModel(id: '5', text: '5'),
            ]),
        SurveyQuestionModel(
            id: '8',
            text: 'How did WFH change your productivity?',
            shortText: '',
            pick: PickType.one,
            displayType: DisplayType.dropdown,
            answers: [
              SurveyAnswerModel(id: '1', text: 'Afghanistan'),
              SurveyAnswerModel(id: '2', text: 'Albania'),
              SurveyAnswerModel(id: '3', text: 'Algeria'),
              SurveyAnswerModel(id: '4', text: 'American Samoa'),
              SurveyAnswerModel(id: '5', text: 'Andorra'),
            ]),
        SurveyQuestionModel(
            id: '9',
            text: 'Please share with us what you think about our service',
            shortText: 'Your thoughts',
            pick: PickType.none,
            displayType: DisplayType.textArea,
            answers: [
              SurveyAnswerModel(id: '1', text: ''),
            ]),
        SurveyQuestionModel(
            id: '10',
            text: "Don't miss out on our Exclusive Promotions!",
            shortText: 'Your thoughts',
            pick: PickType.none,
            displayType: DisplayType.textField,
            answers: [
              SurveyAnswerModel(id: '1', text: 'First Name'),
              SurveyAnswerModel(id: '2', text: 'Mobile No.'),
              SurveyAnswerModel(id: '3', text: 'Email'),
            ]),
      ],
    );
    Future.delayed(const Duration(seconds: 2), () {
      _cache = detail;
      _surveyDetail.add(detail);
    });
  }
}

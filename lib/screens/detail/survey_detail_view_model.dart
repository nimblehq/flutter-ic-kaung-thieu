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
            id: '2',
            text: 'Please share with us what you think about our service',
            shortText: 'Your thoughts',
            pick: PickType.none,
            displayType: DisplayType.textArea,
            answers: [
              SurveyAnswerModel(id: '1', text: ''),
            ]),
        SurveyQuestionModel(
            id: '4',
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

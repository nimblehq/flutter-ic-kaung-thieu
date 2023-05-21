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

  @override
  FutureOr<void> build() {
    fetchMockDetail();
    ref.onDispose(() {
      _surveyDetail.close();
    });
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
            title: 'Question Multi Choice',
            pick: 'one'.toPickType(),
            displayType: 'choice'.toDisplayType(),
            answers: [
              SurveyAnswerModel(id: '1', title: 'Choice 1'),
              SurveyAnswerModel(id: '2', title: 'Choice 2'),
              SurveyAnswerModel(id: '3', title: 'Choice 3'),
              SurveyAnswerModel(id: '4', title: 'Choice 4'),
              SurveyAnswerModel(id: '5', title: 'Choice 5'),
              SurveyAnswerModel(id: '6', title: 'Choice 6'),
            ]),
        SurveyQuestionModel(
            id: '2',
            title: 'Question Multi Choice',
            pick: 'any'.toPickType(),
            displayType: 'choice'.toDisplayType(),
            answers: [
              SurveyAnswerModel(id: '1', title: 'Choice 1'),
              SurveyAnswerModel(id: '2', title: 'Choice 2'),
              SurveyAnswerModel(id: '3', title: 'Choice 3'),
            ]),
      ],
    );
    Future.delayed(const Duration(seconds: 2), () {
      _cache = detail;
      _surveyDetail.add(detail);
    });
  }
}

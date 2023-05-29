import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/model/request/submit_survey_request.dart';
import 'package:survey_flutter/model/request/survey_answer_request.dart';
import 'package:survey_flutter/model/request/survey_question_request.dart';
import 'package:survey_flutter/model/response/survey_detail_data_response.dart';
import 'package:survey_flutter/model/survey_answer_model.dart';
import 'package:survey_flutter/model/survey_detail_model.dart';
import 'package:survey_flutter/model/survey_question_model.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/get_survey_detail_use_case.dart';
import 'package:survey_flutter/usecases/submit_survey_use_case.dart';

final surveyDetailViewModelProvider =
    AsyncNotifierProvider.autoDispose<SurveyDetailViewModel, void>(
        SurveyDetailViewModel.new);

class SurveyDetailViewModel extends AutoDisposeAsyncNotifier<void> {
  SurveyDetailModel? _cache;

  final _surveyDetail = StreamController<SurveyDetailModel>();

  Stream<SurveyDetailModel> get surveyDetail => _surveyDetail.stream;

  final _isSubmitSuccess = StreamController<bool>();

  Stream<bool> get isSubmitSuccess => _isSubmitSuccess.stream;

  final _isError = StreamController<String>();
  Stream<String> get isError => _isError.stream;

  @override
  FutureOr<void> build() {
    ref.onDispose(() {
      _surveyDetail.close();
    });
  }

  Future<void> submitSurvey(String surveyId) async {
    final questionsRequest = _cache?.questions.map((question) =>
        SurveyQuestionRequest(
            id: question.id, answers: _findAnswers(question.answers)));
    SubmitSurveyRequest request = SubmitSurveyRequest(
        surveyId: surveyId, questions: questionsRequest?.toList() ?? []);
    final result = await ref.read(submitSurveyUseCaseProvider).call(request);
    _isSubmitSuccess.add(result is Success);
  }

  List<SurveyAnswerRequest> _findAnswers(
      List<SurveyAnswerModel> surveyAnswers) {
    final result = <SurveyAnswerRequest>[];
    for (var answer in surveyAnswers) {
      if (answer.isAnswer) {
        result
            .add(SurveyAnswerRequest(id: answer.id, answer: answer.textAnswer));
      }
    }
    return result;
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

  Future<void> getSurveyDetail(String surveyId) async {
    final result =
        await ref.read(getSurveyDetailUseCaseProvider).call(surveyId);

    if (result is Success<SurveyDetailDataResponse>) {
      final value = result.value.surveyDetailResponse?.toSurveyDetailModel();

      if (value != null) {
        _cache = value;
        _surveyDetail.add(value);
      } else {
        _isError.add('Unknown error: Null');
      }
    } else if (result is Failed) {
      _isError.add((result as Failed).getErrorMessage());
    }
  }

  void clearError() {
    _isError.add('');
  }
}

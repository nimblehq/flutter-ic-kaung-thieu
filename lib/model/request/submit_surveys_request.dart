import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter/model/request/survey_question_request.dart';

part 'submit_surveys_request.g.dart';

@JsonSerializable()
class SubmitSurveyRequest {
  @JsonKey(name: 'survey_id')
  final String surveyId;
  @JsonKey(name: 'questions')
  final List<SurveyQuestionRequest> questions;

  SubmitSurveyRequest({
    required this.surveyId,
    required this.questions,
  });

  factory SubmitSurveyRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitSurveyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitSurveyRequestToJson(this);
}

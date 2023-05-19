import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter/model/request/survey_question_request.dart';

part 'submit_surveys_request.g.dart';

@JsonSerializable()
class SubmitSurveysRequest {
  @JsonKey(name: 'survey_id')
  final String surveyId;
  @JsonKey(name: 'questions')
  final List<SurveyQuestionRequest> questions;

  SubmitSurveysRequest({
    required this.surveyId,
    required this.questions,
  });

  factory SubmitSurveysRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitSurveysRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitSurveysRequestToJson(this);
}

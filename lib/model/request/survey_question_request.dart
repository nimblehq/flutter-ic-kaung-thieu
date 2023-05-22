import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter/model/request/survey_answer_request.dart';

part 'survey_question_request.g.dart';

@JsonSerializable()
class SurveyQuestionRequest {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'answers')
  final List<SurveyAnswerRequest> answers;

  SurveyQuestionRequest({
    required this.id,
    required this.answers,
  });

  factory SurveyQuestionRequest.fromJson(Map<String, dynamic> json) =>
      _$SurveyQuestionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyQuestionRequestToJson(this);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'survey_answer_request.g.dart';

@JsonSerializable()
class SurveyAnswerRequest {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'answer')
  final String? answer;

  SurveyAnswerRequest({
    required this.id,
    this.answer,
  });

  factory SurveyAnswerRequest.fromJson(Map<String, dynamic> json) =>
      _$SurveyAnswerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyAnswerRequestToJson(this);
}

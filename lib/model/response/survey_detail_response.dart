import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter/model/response/question_response.dart';

part 'survey_detail_response.g.dart';

@JsonSerializable()
class SurveyDetailResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: ' thank_email_above_threshold')
  final String? thankEmailAboveThreshold;
  @JsonKey(name: 'thank_email_below_threshold')
  final String? thankEmailBelowThreshold;
  @JsonKey(name: 'is_active')
  final bool? isActive;
  @JsonKey(name: 'cover_image_url')
  final String? coverImageUrl;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'active_at')
  final String? activeAt;
  @JsonKey(name: 'inactive_at')
  final String? inactiveAt;
  @JsonKey(name: 'survey_type')
  final String? surveyType;
  @JsonKey(name: 'questions')
  final List<QuestionResponse>? questions;

  SurveyDetailResponse({
    this.coverImageUrl,
    this.id,
    this.type,
    this.description,
    this.title,
    this.questions,
    this.surveyType,
    this.inactiveAt,
    this.activeAt,
    this.isActive,
    this.thankEmailBelowThreshold,
    this.thankEmailAboveThreshold,
    this.createdAt,
  });

  factory SurveyDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyDetailResponseToJson(this);
}

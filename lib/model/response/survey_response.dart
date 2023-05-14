import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter/model/hives/survey.dart';
import 'package:survey_flutter/utils/string_extension.dart';

part 'survey_response.g.dart';

@JsonSerializable()
class SurveyResponse {
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

  SurveyResponse({
    this.id,
    this.type,
    this.title,
    this.description,
    this.thankEmailAboveThreshold,
    this.thankEmailBelowThreshold,
    this.isActive,
    this.coverImageUrl,
    this.createdAt,
    this.activeAt,
    this.inactiveAt,
    this.surveyType,
  });

  factory SurveyResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyResponseToJson(this);
}

extension SurveyResponseMapping on SurveyResponse {
  Survey toSurvey() => Survey(
        id: id.orEmpty(),
        type: type.orEmpty(),
        title: title.orEmpty(),
        description: description.orEmpty(),
        thankEmailAboveThreshold: thankEmailAboveThreshold.orEmpty(),
        thankEmailBelowThreshold: thankEmailBelowThreshold.orEmpty(),
        isActive: isActive,
        coverImageUrl: coverImageUrl.orEmpty(),
        createdAt: createdAt.orEmpty(),
        activeAt: activeAt.orEmpty(),
        inactiveAt: inactiveAt.orEmpty(),
        surveyType: surveyType.orEmpty(),
      );
}

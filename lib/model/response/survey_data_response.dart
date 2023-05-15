import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter/api/helpers/japx_helper.dart';
import 'package:survey_flutter/model/hives/survey.dart';
import 'package:survey_flutter/model/response/meta_response.dart';
import 'package:survey_flutter/model/response/survey_response.dart';

part 'survey_data_response.g.dart';

@JsonSerializable()
class SurveyDataResponse {
  @JsonKey(name: 'data')
  final List<SurveyResponse> surveys;
  @JsonKey(name: 'meta')
  final MetaResponse meta;

  SurveyDataResponse(this.surveys, this.meta);

  factory SurveyDataResponse.fromJson(Map<String, dynamic> json) {
    final decodedJson = decodeJson(json);
    return _$SurveyDataResponseFromJson(decodedJson);
  }
}

extension SurveyDataResponseMapping on SurveyDataResponse {
  List<Survey> toSurveys() =>
      surveys.map((surveyResponse) => surveyResponse.toSurvey()).toList();
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter/api/helpers/japx_helper.dart';
import 'package:survey_flutter/model/response/survey_response.dart';

part 'survey_data_response.g.dart';

@JsonSerializable()
class SurveyDataResponse {
  @JsonKey(name: 'data')
  final List<SurveyResponse> surveys;

  SurveyDataResponse(this.surveys);

  factory SurveyDataResponse.fromJson(Map<String, dynamic> json) {
    final decodedJson = decodeJson(json);
    return _$SurveyDataResponseFromJson(decodedJson);
  }
}

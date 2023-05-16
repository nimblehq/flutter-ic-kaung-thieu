import 'package:survey_flutter/model/hives/survey.dart';
import 'package:survey_flutter/model/response/survey_response.dart';
import 'package:survey_flutter/utils/string_extension.dart';

class SurveyModel {
  final String title;
  final String description;
  final String coverImageUrl;

  SurveyModel({
    required this.title,
    required this.description,
    required this.coverImageUrl,
  });
}

extension SurveyMapping on Survey {
  SurveyModel fromSurveyToSurveyModel() {
    return SurveyModel(
      title: title,
      description: description,
      coverImageUrl: '${coverImageUrl}l',
    );
  }
}

extension SurveyResponseMapping on SurveyResponse {
  SurveyModel fromSurveyResponseToSurveyModel() {
    return SurveyModel(
      title: title.orEmpty(),
      description: description.orEmpty(),
      coverImageUrl: '${coverImageUrl}l',
    );
  }
}

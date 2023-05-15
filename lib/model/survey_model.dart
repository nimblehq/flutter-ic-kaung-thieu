import 'package:survey_flutter/model/hives/survey.dart';

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

extension SurveyModelMapping on Survey {
  SurveyModel toSurveyModel() {
    return SurveyModel(
      title: title,
      description: description,
      coverImageUrl: '${coverImageUrl}l',
    );
  }
}

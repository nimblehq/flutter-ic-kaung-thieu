import 'package:survey_flutter/model/response/survey_detail_response.dart';
import 'package:survey_flutter/utils/string_extension.dart';

import 'survey_question_model.dart';

class SurveyDetailModel {
  final String id;
  final String title;
  final String description;
  final String coverImageUrl;
  final List<SurveyQuestionModel> questions;

  SurveyDetailModel({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImageUrl,
    required this.questions,
  });
}

extension SurveyDetailModelExtension on SurveyDetailResponse {
  SurveyDetailModel toSurveyDetailModel() {
    return SurveyDetailModel(
      id: id.orEmpty(),
      title: title.orEmpty(),
      description: description.orEmpty(),
      coverImageUrl: '${coverImageUrl.orEmpty()}l',
      questions: questions?.toSurveyQuestionModels() ?? [],
    );
  }
}

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

class SurveyAnswerModel {
  final String id;
  final String title;
  bool isAnswer;

  SurveyAnswerModel({
    required this.id,
    required this.title,
    this.isAnswer = false,
  });
}

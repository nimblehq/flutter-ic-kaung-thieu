class SurveyAnswerModel {
  final String id;
  final String text;
  bool isAnswer;
  String? textAnswer;

  SurveyAnswerModel({
    required this.id,
    required this.text,
    this.isAnswer = false,
    this.textAnswer,
  });
}

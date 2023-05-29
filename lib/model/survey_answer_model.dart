import 'package:survey_flutter/model/response/answer_response.dart';
import 'package:survey_flutter/utils/string_extension.dart';

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

extension SurveyAnswerModelExtension on List<AnswerResponse> {
  List<SurveyAnswerModel> toSurveyAnswerModels() {
    return map(
      (answer) => SurveyAnswerModel(
        id: answer.id.orEmpty(),
        text: answer.text.orEmpty(),
      ),
    ).toList();
  }
}

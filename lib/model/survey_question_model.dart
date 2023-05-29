import 'package:survey_flutter/model/response/question_response.dart';
import 'package:survey_flutter/model/survey_answer_model.dart';
import 'package:survey_flutter/utils/string_extension.dart';

class SurveyQuestionModel {
  final String id;
  final String text;
  final String shortText;
  final PickType pick;
  final DisplayType displayType;
  final List<SurveyAnswerModel> answers;

  SurveyQuestionModel({
    required this.id,
    required this.text,
    required this.shortText,
    required this.pick,
    required this.displayType,
    required this.answers,
  });
}

extension SurveyQuestionModelExtension on List<QuestionResponse> {
  List<SurveyQuestionModel> toSurveyQuestionModels() {
    return map(
      (question) => SurveyQuestionModel(
          id: question.id.orEmpty(),
          text: question.text.orEmpty(),
          shortText: question.shortText.orEmpty(),
          pick: question.pick?.toPickType() ?? PickType.none,
          displayType:
              question.displayType?.toDisplayType() ?? DisplayType.undefined,
          answers: question.answers?.toSurveyAnswerModels() ?? []),
    ).toList();
  }
}

enum DisplayType {
  undefined(''),
  choice('choice'),
  textArea('textarea'),
  textField('textfield'),
  nps('nps'),
  smiley('smiley'),
  star('star'),
  thumbs('thumbs'),
  heart('heart'),
  dropdown('dropdown'),
  intro('intro'),
  outro('outro');

  final String typeValue;

  const DisplayType(this.typeValue);
}

enum PickType {
  none('none'),
  one('one'),
  any('any');

  final String pickValue;

  const PickType(this.pickValue);
}

extension PickExtension on String {
  PickType toPickType() {
    if (this == PickType.any.pickValue) {
      return PickType.any;
    } else if (this == PickType.one.pickValue) {
      return PickType.one;
    } else {
      return PickType.none;
    }
  }
}

extension DisplayTypeExtension on String {
  DisplayType toDisplayType() {
    if (this == DisplayType.choice.typeValue) {
      return DisplayType.choice;
    } else if (this == DisplayType.textArea.typeValue) {
      return DisplayType.textArea;
    } else if (this == DisplayType.textField.typeValue) {
      return DisplayType.textField;
    } else if (this == DisplayType.nps.typeValue) {
      return DisplayType.nps;
    } else if (this == DisplayType.smiley.typeValue) {
      return DisplayType.smiley;
    } else if (this == DisplayType.star.typeValue) {
      return DisplayType.star;
    } else if (this == DisplayType.thumbs.typeValue) {
      return DisplayType.thumbs;
    } else if (this == DisplayType.heart.typeValue) {
      return DisplayType.heart;
    } else if (this == DisplayType.dropdown.typeValue) {
      return DisplayType.dropdown;
    } else if (this == DisplayType.intro.typeValue) {
      return DisplayType.intro;
    } else {
      return DisplayType.outro;
    }
  }
}

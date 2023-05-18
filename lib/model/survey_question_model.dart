import 'package:survey_flutter/model/survey_answer_model.dart';

class SurveyQuestionModel {
  final String id;
  final String title;
  final PickType pick;
  final DisplayType displayType;
  final List<SurveyAnswerModel> answers;

  SurveyQuestionModel({
    required this.id,
    required this.title,
    required this.pick,
    required this.displayType,
    required this.answers,
  });
}

enum DisplayType {
  choice('choice');

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
    } else {
      throw Exception('Unimplemented Display Type: $this');
    }
  }
}
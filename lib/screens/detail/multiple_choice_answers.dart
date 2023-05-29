import 'package:flutter/material.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/model/survey_answer_model.dart';

class MultipleChoiceAnswers extends StatefulWidget {
  final ValueChanged<String> onChoiceClick;
  final List<SurveyAnswerModel> answers;

  const MultipleChoiceAnswers({
    required this.answers,
    required this.onChoiceClick,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => MultipleChoiceState();
}

class MultipleChoiceState extends State<MultipleChoiceAnswers> {
  int? _selectedIndex;

  TextTheme get _textTheme => Theme.of(context).textTheme;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.answers.length,
        itemBuilder: (BuildContext context, int index) {
          final answer = widget.answers[index];
          return _buildChoiceItem(
              text: answer.text,
              isSelected: _selectedIndex == index,
              isAnswer: answer.isAnswer,
              onClick: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onChoiceClick.call(widget.answers[index].id);
              });
        });
  }

  Widget _buildChoiceItem({
    required String text,
    required bool isSelected,
    required bool isAnswer,
    required VoidCallback onClick,
  }) {
    TextStyle? getTextStyle() {
      if (isSelected) {
        return _textTheme.labelLarge?.copyWith(color: Colors.white);
      } else {
        return _textTheme.labelLarge?.copyWith(
          color: Colors.white.withOpacity(0.6),
          fontWeight: FontWeight.normal,
        );
      }
    }

    String getImagePath() {
      if (isAnswer) {
        if (isSelected) {
          return Assets.images.icChoice.path;
        } else {
          return Assets.images.icChoiceGray.path;
        }
      } else {
        return Assets.images.icEmptyChoice.path;
      }
    }

    Color getDividerColor() {
      if (isSelected) {
        return Colors.white;
      } else {
        return Colors.transparent;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: GestureDetector(
        onTap: onClick,
        child: Column(
          children: [
            Divider(
              color: getDividerColor(),
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(children: [
                Expanded(
                  child: Text(
                    text,
                    style: getTextStyle(),
                  ),
                ),
                Image.asset(getImagePath()),
              ]),
            ),
            Divider(
              color: getDividerColor(),
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}

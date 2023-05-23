import 'package:flutter/material.dart';
import 'package:survey_flutter/model/survey_answer_model.dart';
import 'package:survey_flutter/model/survey_question_model.dart';

class EmoticonChoiceAnswers extends StatefulWidget {
  final ValueChanged<String> onChoiceClick;
  final List<SurveyAnswerModel> answers;
  final DisplayType displayType;

  const EmoticonChoiceAnswers({
    required this.onChoiceClick,
    required this.answers,
    required this.displayType,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => EmoticonChoiceAnswersState();
}

class EmoticonChoiceAnswersState extends State<EmoticonChoiceAnswers> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    bool isSelectedEmoticon(int index) {
      if (_selectedIndex == index) {
        return true;
      }
      if (widget.displayType != DisplayType.smiley &&
          _selectedIndex != null &&
          index < (_selectedIndex ?? 0)) {
        return true;
      }
      return false;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int index = 0; index < 5; index++) ...[
          TextButton(
            onPressed: () {
              setState(() {
                _selectedIndex = index;
              });
              widget.onChoiceClick(widget.answers[index].id);
            },
            child: _buildText(
              index: index,
              isSelected: isSelectedEmoticon(index),
            ),
          )
        ]
      ],
    );
  }

  Widget _buildText({required int index, required bool isSelected}) {
    switch (widget.displayType) {
      case DisplayType.star:
        return Text(
          '⭐',
          style: TextStyle(
            fontSize: 24,
            color: isSelected ? null : Colors.transparent.withOpacity(0.4),
          ),
        );
      case DisplayType.thumbs:
        return Text(
          '👍',
          style: TextStyle(
            fontSize: 24,
            color: isSelected ? null : Colors.transparent.withOpacity(0.4),
          ),
        );
      case DisplayType.heart:
        return Text(
          '❤️',
          style: TextStyle(
            fontSize: 24,
            color: isSelected ? null : Colors.transparent.withOpacity(0.4),
          ),
        );

      default:
        switch (index) {
          case 0:
            return Text(
              '😡',
              style: TextStyle(
                fontSize: 24,
                color: isSelected ? null : Colors.transparent.withOpacity(0.4),
              ),
            );
          case 1:
            return Text(
              '😕',
              style: TextStyle(
                fontSize: 24,
                color: isSelected ? null : Colors.transparent.withOpacity(0.4),
              ),
            );
          case 2:
            return Text(
              '😐',
              style: TextStyle(
                fontSize: 24,
                color: isSelected ? null : Colors.transparent.withOpacity(0.4),
              ),
            );
          case 3:
            return Text(
              '🙂',
              style: TextStyle(
                fontSize: 24,
                color: isSelected ? null : Colors.transparent.withOpacity(0.4),
              ),
            );
          default:
            return Text(
              '😄',
              style: TextStyle(
                fontSize: 24,
                color: isSelected ? null : Colors.transparent.withOpacity(0.4),
              ),
            );
        }
    }
  }
}

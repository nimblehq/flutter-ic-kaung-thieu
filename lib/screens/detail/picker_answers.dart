import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:survey_flutter/model/survey_answer_model.dart';

class PickerAnswers extends StatefulWidget {
  final ValueChanged<String> onChoiceClick;
  final List<SurveyAnswerModel> answers;

  const PickerAnswers({
    required this.answers,
    required this.onChoiceClick,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => PickerAnswersState();
}

class PickerAnswersState extends State<PickerAnswers> {
  TextTheme get _textTheme => Theme.of(context).textTheme;

  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: CupertinoPicker(
          selectionOverlay: Stack(
            children: const [
              Align(
                alignment: Alignment.topCenter,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Divider(
                  color: Colors.white,
                ),
              )
            ],
          ),
          itemExtent: 56,
          onSelectedItemChanged: (int selectedItem) {
            setState(() {
              _selectedItem = selectedItem;
            });
            widget.onChoiceClick(widget.answers[selectedItem].id);
          },
          children: [
            for (int index = 0; index < widget.answers.length; index++) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  widget.answers[index].text,
                  style: _selectedItem == index
                      ? _textTheme.labelLarge
                      : _textTheme.bodyLarge,
                ),
              )
            ]
          ]),
    );
  }
}

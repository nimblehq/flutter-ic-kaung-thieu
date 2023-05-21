import 'package:flutter/material.dart';
import 'package:survey_flutter/model/survey_answer_model.dart';

class TextFieldAnswer extends StatefulWidget {
  final Function(String, String) onTextChange;
  final List<SurveyAnswerModel> answers;

  const TextFieldAnswer({
    required this.answers,
    required this.onTextChange,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => TextFieldAnswerState();
}

class TextFieldAnswerState extends State<TextFieldAnswer> {
  TextTheme get _textTheme => Theme.of(context).textTheme;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.answers.length,
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 14,
      ),
      itemBuilder: (BuildContext context, int index) {
        final answer = widget.answers[index];
        return _buildTextField(answer, index == widget.answers.length - 1);
      },
    );
  }

  Widget _buildTextField(SurveyAnswerModel answer, bool isLastAnswer) {
    Color getBackgroundColor() => answer.textAnswer?.isNotEmpty ?? false
        ? Colors.white.withOpacity(0.5)
        : Colors.white.withOpacity(0.4);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextField(
        style: _textTheme.bodyMedium,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            filled: true,
            fillColor: getBackgroundColor(),
            hintText: answer.text,
            hintStyle: _textTheme.bodyMedium
                ?.copyWith(color: Colors.white.withOpacity(0.5))),
        onChanged: (text) {
          widget.onTextChange(answer.id, text);
        },
        textInputAction:
            isLastAnswer ? TextInputAction.done : TextInputAction.next,
      ),
    );
  }
}

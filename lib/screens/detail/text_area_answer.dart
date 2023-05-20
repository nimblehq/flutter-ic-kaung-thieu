import 'package:flutter/material.dart';

class TextAreaAnswer extends StatefulWidget {
  final ValueChanged<String> onTextChange;
  final String hint;

  const TextAreaAnswer({
    required this.hint,
    required this.onTextChange,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => TextAreaAnswerState();
}

class TextAreaAnswerState extends State<TextAreaAnswer> {
  TextTheme get _textTheme => Theme.of(context).textTheme;
  String _textValue = '';

  @override
  Widget build(BuildContext context) {
    Color getBackgroundColor() => _textValue.isNotEmpty
        ? Colors.white.withOpacity(0.5)
        : Colors.white.withOpacity(0.4);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextField(
        style: _textTheme.bodyMedium,
        maxLines: 7,
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
            hintText: widget.hint,
            hintStyle: _textTheme.bodyMedium
                ?.copyWith(color: Colors.white.withOpacity(0.5))),
        onChanged: (text) {
          setState(() {
            _textValue = text;
          });
          widget.onTextChange(text);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:survey_flutter/model/survey_answer_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NpsAnswer extends StatefulWidget {
  final ValueChanged<String> onChoiceClick;
  final List<SurveyAnswerModel> answers;

  const NpsAnswer({
    required this.onChoiceClick,
    required this.answers,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => NpsAnswerState();
}

class NpsAnswerState extends State<NpsAnswer> {
  TextTheme get _textTheme => Theme.of(context).textTheme;

  AppLocalizations get _localizations => AppLocalizations.of(context)!;
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int index = 0; index < widget.answers.length; index++) ...[
              _buildNpsItem(
                answer: widget.answers[index],
                index: index,
                isStartItem: index == 0,
                isEndItem: index == (widget.answers.length - 1),
              )
            ]
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Text(
                _localizations.surveyNpsNotAtAllLikely,
                style: _textTheme.labelMedium?.copyWith(color: () {
                  if (_selectedIndex != null &&
                      (_selectedIndex ?? 0) <
                          widget.answers.length / 2.round()) {
                    return Colors.white;
                  } else {
                    return Colors.white.withOpacity(0.5);
                  }
                }()),
              ),
              const Expanded(child: SizedBox.shrink()),
              Text(
                _localizations.surveyNpsExtremelyLikely,
                style: _textTheme.labelMedium?.copyWith(color: () {
                  if (_selectedIndex != null &&
                      (_selectedIndex ?? 0) >=
                          (widget.answers.length / 2).round()) {
                    return Colors.white;
                  } else {
                    return Colors.white.withOpacity(0.5);
                  }
                }()),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNpsItem({
    required SurveyAnswerModel answer,
    bool isStartItem = false,
    bool isEndItem = false,
    required int index,
  }) {
    const radius = Radius.circular(10);
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        widget.onChoiceClick(answer.id);
      },
      child: Container(
        width: 33,
        height: 56,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: () {
            if (isStartItem) {
              return const BorderRadius.only(
                topLeft: radius,
                bottomLeft: radius,
              );
            } else if (isEndItem) {
              return const BorderRadius.only(
                bottomRight: radius,
                topRight: radius,
              );
            }
          }(),
        ),
        child: Center(
          child: Text(
            answer.text,
            style: () {
              if (_selectedIndex != null && index <= (_selectedIndex ?? 0)) {
                return _textTheme.labelLarge;
              } else {
                return _textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.5),
                );
              }
            }(),
          ),
        ),
      ),
    );
  }
}

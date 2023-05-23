import 'package:flutter/material.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StartSurveyContent extends StatefulWidget {
  final String title;
  final String description;
  final VoidCallback onStartSurvey;

  const StartSurveyContent({
    required this.title,
    required this.description,
    required this.onStartSurvey,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => StartSurveyContentState();
}

class StartSurveyContentState extends State<StartSurveyContent> {
  TextTheme get _textTheme => Theme.of(context).textTheme;

  AppLocalizations get _localizations => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    {
      return Column(
        children: [
          _buildToolbar(true),
          Padding(
            padding: const EdgeInsets.only(top: 30.5, left: 20, right: 20),
            child: Text(
              widget.title,
              style: _textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
            child: Text(
              widget.description,
              style: _textTheme.bodyMedium,
            ),
          ),
          const Expanded(child: SizedBox.shrink()),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 34, right: 20),
              child: SizedBox(
                width: 140,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: widget.onStartSurvey,
                  child: Text(
                    _localizations.surveyDetailStartSurvey,
                    style:
                        _textTheme.labelMedium?.copyWith(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildToolbar(bool showBack) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (showBack) ...[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 14,
                top: 52,
              ),
              child: IconButton(
                  icon: Image.asset(Assets.images.icBack.path),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ),
          ),
        ] else ...[
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 16,
                top: 52,
              ),
              child: IconButton(
                  icon: Image.asset(Assets.images.icClose.path),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ),
          )
        ]
      ],
    );
  }
}

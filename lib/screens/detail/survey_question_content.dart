import 'package:flutter/material.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SurveyQuestionContent extends StatefulWidget {
  final String title;
  final int page;
  final int totalPage;
  final VoidCallback onPressNext;
  final Widget child;

  const SurveyQuestionContent({
    required this.title,
    required this.page,
    required this.totalPage,
    required this.onPressNext,
    required this.child,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => SurveyQuestionContentState();
}

class SurveyQuestionContentState extends State<SurveyQuestionContent> {
  TextTheme get _textTheme => Theme.of(context).textTheme;
  AppLocalizations get _localizations => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildToolbar(false),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 40.5, left: 20, right: 20),
            child: Text(
              '${widget.page}/${widget.totalPage}',
              style: _textTheme.labelSmall
                  ?.copyWith(color: Colors.white.withOpacity(0.5)),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
            child: Text(
              widget.title,
              style: _textTheme.titleLarge,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: widget.child,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 34, right: 20),
            child: widget.page == widget.totalPage
                ? SizedBox(
                    width: 140,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: widget.onPressNext,
                      child: Text(
                        _localizations.surveySubmit,
                        style: _textTheme.labelMedium
                            ?.copyWith(color: Colors.black),
                      ),
                    ),
                  )
                : SizedBox(
                    width: 56,
                    height: 56,
                    child: FloatingActionButton(
                      onPressed: widget.onPressNext,
                      backgroundColor: Colors.white,
                      child: Image.asset(Assets.images.icNavNext.path),
                    ),
                  ),
          ),
        ),
      ],
    );
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

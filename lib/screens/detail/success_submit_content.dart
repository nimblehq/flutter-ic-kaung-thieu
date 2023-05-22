import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const _lottieUrl = 'https://assets2.lottiefiles.com/packages/lf20_pmYw5P.json';

class SurveySubmitSuccessScreen extends StatefulWidget {
  final VoidCallback onAnimationEnd;

  const SurveySubmitSuccessScreen({
    required this.onAnimationEnd,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => SurveySubmitSuccessState();
}

class SurveySubmitSuccessState extends State<SurveySubmitSuccessScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  TextTheme get _textTheme => Theme.of(context).textTheme;

  AppLocalizations get _localizations => AppLocalizations.of(context)!;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
              _lottieUrl,
              width: 200,
              height: 200,
              controller: _controller,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..forward().whenComplete(widget.onAnimationEnd);
              },
            ),
            Text(
              _localizations.surveySubmitSuccessMsg,
              style: _textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

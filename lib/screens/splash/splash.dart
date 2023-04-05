import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:survey_flutter/gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool _isLogoVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLogoVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      fit: StackFit.expand,
      children: [
        Image.asset(
          Assets.images.splashBackground.path,
        ),
        AnimatedOpacity(
          opacity: _isLogoVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: Image.asset(
            Assets.images.nimbleLogoWhite.path,
          ),
        ),
      ],
    );
  }
}

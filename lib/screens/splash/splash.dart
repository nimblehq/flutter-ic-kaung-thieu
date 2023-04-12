import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/screens/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  double _logoOpacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _logoOpacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          alignment: AlignmentDirectional.center,
          fit: StackFit.expand,
          children: [
            // Only this https://stackoverflow.com/a/64837703 way works for me to fill the image
            Image.asset(
              Assets.images.splashBackground.path,
              fit: BoxFit.cover,
            ),
            AnimatedOpacity(
              opacity: _logoOpacity,
              duration: const Duration(seconds: 2),
              child: Image.asset(
                Assets.images.nimbleLogoWhite.path,
              ),
              onEnd: () => context.go(routePathLoginScreen),
            ),
          ],
        );
      }),
    );
  }
}

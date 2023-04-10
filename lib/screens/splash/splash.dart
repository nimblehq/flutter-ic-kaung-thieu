import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/screens/login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool _isLogoVisible = false;
  bool _shouldAnimateLogo = false;

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
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              top: _shouldAnimateLogo ? 153 : constraints.maxHeight / 2,
              child: AnimatedOpacity(
                  opacity: _isLogoVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Image.asset(
                    Assets.images.nimbleLogoWhite.path,
                  ),
                  onEnd: () {
                    setState(() {
                      _shouldAnimateLogo = true;
                    });
                  }),
              onEnd: () => context.go(routePathLoginScreen),
            )
          ],
        );
      }),
    );
  }
}

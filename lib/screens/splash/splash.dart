import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter/api/storage/shared_preference.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/screens/home/home_screen.dart';
import 'package:survey_flutter/screens/login/login_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
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
    final sharedPreference = ref.watch(sharedPreferenceProvider);

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
            FutureBuilder(
              builder: (context, snapShot) {
                return AnimatedOpacity(
                  opacity: _logoOpacity,
                  duration: const Duration(seconds: 1),
                  child: Image.asset(
                    Assets.images.nimbleLogoWhite.path,
                  ),
                  onEnd: () {
                    if (snapShot.hasData && (snapShot.data as bool)) {
                      context.go(routePathHomeScreen);
                    } else {
                      context.go(routePathLoginScreen);
                    }
                  },
                );
              },
              future: sharedPreference.isAlreadyLoggedIn(),
            ),
          ],
        );
      }),
    );
  }
}

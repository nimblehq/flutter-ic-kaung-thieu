import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/screens/home/home_screen.dart';
import 'package:survey_flutter/screens/login/login_screen.dart';
import 'package:survey_flutter/screens/splash/splash_view_model.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  double _logoOpacity = 0;

  final _isAlreadyLoggedInStream = StreamProvider.autoDispose<bool>(
      (ref) => ref.watch(splashViewModelProvider.notifier).isAlreadyLoggedIn);

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
            Consumer(builder: (_, widgetRef, child) {
              final isLoggedIn =
                  widgetRef.watch(_isAlreadyLoggedInStream).value ?? false;
              return AnimatedOpacity(
                opacity: _logoOpacity,
                duration: const Duration(seconds: 1),
                child: Image.asset(
                  Assets.images.nimbleLogoWhite.path,
                ),
                onEnd: () {
                  if (isLoggedIn) {
                    context.go(routePathHomeScreen);
                  } else {
                    context.go(routePathLoginScreen);
                  }
                },
              );
            })
          ],
        );
      }),
    );
  }
}

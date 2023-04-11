import 'package:flutter/material.dart';
import 'package:survey_flutter/gen/assets.gen.dart';

const routePathLoginScreen = '/login';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          alignment: AlignmentDirectional.center,
          fit: StackFit.expand,
          children: [
            Image.asset(
              Assets.images.splashBackground.path,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 153,
              child: Image.asset(
                Assets.images.nimbleLogoWhite.path,
              ),
            )
          ]),
    );
  }
}

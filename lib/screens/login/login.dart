import 'package:flutter/cupertino.dart';

import '../../gen/assets.gen.dart';

const routePathLoginScreen = '/login';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
          alignment: AlignmentDirectional.center,
          fit: StackFit.expand,
          children: [
            Image.asset(
              Assets.images.splashBackground.path,
            ),
            Positioned(
              top: 153,
              child: Image.asset(
                Assets.images.nimbleLogoWhite.path,
              ),
            )
          ]);
    });
  }
}

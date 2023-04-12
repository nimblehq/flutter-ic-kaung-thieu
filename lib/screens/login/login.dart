import 'dart:math';
import 'package:flutter/material.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/utils/keyboard_manager.dart';
import 'package:survey_flutter/screens/login/login_component_id.dart';
import 'package:survey_flutter/screens/widgets/form_field_decoration.dart';
import 'package:survey_flutter/screens/widgets/blur_image.dart';

const routePathLoginScreen = '/login';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  late final AnimationController _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600), vsync: this)
    ..forward();

  late final Animation<double> _logoScaleAnimation = Tween(begin: 1.0, end: 0.8)
      .animate(
          CurvedAnimation(parent: _logoAnimationController, curve: Curves.easeIn));

  late final Animation<Offset> _logoOffsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, -0.3),
  ).animate(CurvedAnimation(
    parent: _logoAnimationController,
    curve: Curves.easeIn,
  ));

  late final AnimationController _formAnimationController = AnimationController(
      duration: const Duration(milliseconds: 700), vsync: this)
    ..forward();

  late final Animation<double> _formAnimation =
      CurvedAnimation(parent: _formAnimationController, curve: Curves.easeIn);

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _formAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // A bit hack!!!
    double formHeight = 208;

    return GestureDetector(
      onTap: () {
        KeyboardManager.dismiss(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
            alignment: AlignmentDirectional.center,
            fit: StackFit.expand,
            children: [
              BlurImage(
                image: Image.asset(
                  Assets.images.splashBackground.path,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black,
                    ],
                  ),
                ),
              ),
              SlideTransition(
                position: _logoOffsetAnimation,
                child: ScaleTransition(
                  scale: _logoScaleAnimation,
                  child: Image.asset(
                    Assets.images.nimbleLogoWhite.path,
                  ),
                ),
              ),
              SingleChildScrollView(
                reverse: true,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  children: [
                    FadeTransition(
                      opacity: _formAnimation,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: _LoginForm(
                          key: _formKey,
                        ),
                      ),
                    ),
                    SizedBox(
                        height: max(
                      24,
                      (screenHeight - formHeight) / 2 -
                          MediaQuery.of(context).viewInsets.bottom,
                    )),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  TextFormField _emailTextField(TextStyle? textStyle) {
    return TextFormField(
      key: LoginScreenKey.emailTextField,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      decoration: FormFieldDecoration(
        hint: 'Email',
        hintTextStyle: textStyle,
      ),
      style: textStyle,
    );
  }

  TextFormField _passwordTextField(TextStyle? textStyle) {
    return TextFormField(
      key: LoginScreenKey.passwordTextField,
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      obscuringCharacter: "●",
      decoration:
          FormFieldDecoration(hint: 'Password', hintTextStyle: textStyle),
      style: textStyle,
    );
  }

  ElevatedButton _loginButton(TextStyle? textStyle) {
    return ElevatedButton(
      key: LoginScreenKey.loginButton,
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(textStyle),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.black),
        overlayColor: MaterialStateProperty.all(Colors.black12),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      child: Text('Log in'),
      onPressed: () => {
        KeyboardManager.dismiss(context)
        // TODO - implement login
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _emailTextField(Theme.of(context).textTheme.bodyLarge),
          const SizedBox(
            height: 20,
          ),
          _passwordTextField(Theme.of(context).textTheme.bodyLarge),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 56,
            width: double.infinity,
            child: _loginButton(Theme.of(context).textTheme.labelLarge),
          )
        ],
      ),
    );
  }
}

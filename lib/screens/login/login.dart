import 'dart:math';
import 'package:flutter/material.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/utils/keyboard_manager.dart';
import 'package:survey_flutter/screens/widgets/form_field_decoration.dart';
import 'package:survey_flutter/screens/widgets/blur_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      .animate(CurvedAnimation(
          parent: _logoAnimationController, curve: Curves.easeIn));

  late final Animation<Offset> _logoOffsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, -0.3),
  ).animate(CurvedAnimation(
    parent: _logoAnimationController,
    curve: Curves.easeIn,
  ));

  late final AnimationController _formAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600), vsync: this)
    ..forward();

  late final Animation<double> _opacityAnimation =
      CurvedAnimation(parent: _formAnimationController, curve: Curves.easeIn);

  late final SlideTransition _logo = SlideTransition(
    position: _logoOffsetAnimation,
    child: ScaleTransition(
      scale: _logoScaleAnimation,
      child: Image.asset(
        Assets.images.nimbleLogoWhite.path,
      ),
    ),
  );

  late final BlurImage _blurBackground = BlurImage(
    image: Image.asset(
      Assets.images.splashBackground.path,
      fit: BoxFit.cover,
    ),
  );

  late final FadeTransition _gradientOverlay = FadeTransition(
    opacity: _opacityAnimation,
    child: Container(
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
  );

  late final FadeTransition _loginForm = FadeTransition(
    opacity: _opacityAnimation,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: _LoginForm(
        key: _formKey,
      ),
    ),
  );

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _formAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double formHeight = 208;

    Column bottomPadding = Column(children: [
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
    ]);

    return GestureDetector(
      onTap: () => KeyboardManager.dismiss(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
            alignment: AlignmentDirectional.center,
            fit: StackFit.expand,
            children: [
              _blurBackground,
              _gradientOverlay,
              _logo,
              SingleChildScrollView(
                reverse: true,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  children: [
                    _loginForm,
                    bottomPadding,
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
  AppLocalizations get _localizations => AppLocalizations.of(context)!;
  TextTheme get _textTheme => Theme.of(context).textTheme;

  TextFormField get _emailTextField => TextFormField(
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        decoration: FormFieldDecoration(
          hint: _localizations.emailInputHint,
          hintTextStyle: _textTheme.bodyLarge,
        ),
        style: _textTheme.bodyLarge,
      );

  TextFormField get _passwordTextField => TextFormField(
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        obscuringCharacter: "●",
        decoration: FormFieldDecoration(
            hint: _localizations.passwordInputHint,
            hintTextStyle: _textTheme.bodyLarge),
        style: _textTheme.bodyLarge,
      );

  ElevatedButton get _loginButton => ElevatedButton(
        style: ButtonStyle(
          textStyle:
              MaterialStateProperty.all(Theme.of(context).textTheme.labelLarge),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          overlayColor: MaterialStateProperty.all(Colors.black12),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        child: Text(_localizations.loginButton),
        onPressed: () {
          KeyboardManager.dismiss(context);
          // TODO - implement login
        },
      );

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _emailTextField,
          const SizedBox(
            height: 20,
          ),
          _passwordTextField,
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 56,
            width: double.infinity,
            child: _loginButton,
          )
        ],
      ),
    );
  }
}

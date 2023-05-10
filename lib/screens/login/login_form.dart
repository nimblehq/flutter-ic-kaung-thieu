import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter/screens/home/home_screen.dart';
import 'package:survey_flutter/screens/login/login_view_model.dart';
import 'package:survey_flutter/screens/widgets/alert_dialog.dart';
import 'package:survey_flutter/screens/widgets/form_field_decoration.dart';
import 'package:survey_flutter/theme/constant.dart';
import 'package:survey_flutter/utils/keyboard_manager.dart';

final isValidEmailStreamProvider = StreamProvider.autoDispose(
    (ref) => ref.watch(loginViewModelProvider.notifier).isValidEmail);

final isValidPasswordStreamProvider = StreamProvider.autoDispose(
    (ref) => ref.watch(loginViewModelProvider.notifier).isValidPassword);

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  AppLocalizations get _localizations => AppLocalizations.of(context)!;

  TextTheme get _textTheme => Theme.of(context).textTheme;

  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool _isFormSubmitted = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    emailController.addListener(() {
      ref
          .read(loginViewModelProvider.notifier)
          .checkEmail(emailController.text);
    });
    passwordController = TextEditingController();
    passwordController.addListener(() {
      ref
          .read(loginViewModelProvider.notifier)
          .checkPassword(passwordController.text);
    });
  }

  String? _emailValidator() {
    final isValidEmail = ref.watch(isValidEmailStreamProvider).value ?? false;
    if (!isValidEmail && _isFormSubmitted) {
      return _localizations.invalidEmailError;
    }
    return null;
  }

  String? _passwordValidator() {
    final isValidPassword =
        ref.watch(isValidPasswordStreamProvider).value ?? false;
    if (!isValidPassword && _isFormSubmitted) {
      return _localizations.invalidPasswordError;
    }
    return null;
  }

  Widget get _emailTextField => Consumer(builder: (context, widgetRef, _) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          decoration: FormFieldDecoration(
            hint: _localizations.emailInputHint,
            hintTextStyle: _textTheme.bodyLarge,
            errorString: _emailValidator(),
          ),
          style: _textTheme.bodyLarge,
          controller: emailController,
        );
      });

  TextFormField get _passwordTextField => TextFormField(
        autocorrect: false,
        obscureText: true,
        decoration: FormFieldDecoration(
          hint: _localizations.passwordInputHint,
          hintTextStyle: _textTheme.bodyLarge,
          errorString: _passwordValidator(),
        ),
        style: _textTheme.bodyLarge,
        controller: passwordController,
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
              borderRadius: BorderRadius.circular(Metrics.defaultBorderRadius),
            ),
          ),
        ),
        onPressed: _submitForm,
        child: Consumer(
          builder: (context, widgetRef, child) {
            final loginViewModel = widgetRef.watch(loginViewModelProvider);
            return (loginViewModel.isLoading && !loginViewModel.hasError) ||
                    loginViewModel.isReloading
                ? const CircularProgressIndicator()
                : Text(_localizations.loginButton);
          },
        ),
      );

  void _submitForm() {
    setState(() => _isFormSubmitted = true);

    final isReadyToLogin =
        (ref.watch(isValidEmailStreamProvider).value ?? false) &&
            (ref.watch(isValidPasswordStreamProvider).value ?? false);
    KeyboardManager.dismiss(context);
    if (isReadyToLogin) {
      ref.read(loginViewModelProvider.notifier).login();
    }
  }

  @override
  Widget build(BuildContext context) {
    const fieldSpacing = 20.0;
    ref.listen<AsyncValue<void>>(loginViewModelProvider, (previous, next) {
      next.maybeWhen(
        data: (_) => context.go(routePathHomeScreen),
        error: (error, _) {
          showAlertDialog(
              context: context,
              title: _localizations.loginFailAlertTitle,
              message:
                  (error as String?) ?? _localizations.loginFailAlertMessage,
              actions: [
                TextButton(
                  child: Text(_localizations.okText),
                  onPressed: () => Navigator.pop(context),
                ),
              ]);
        },
        orElse: () {},
      );
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _emailTextField,
        const SizedBox(
          height: fieldSpacing,
        ),
        _passwordTextField,
        const SizedBox(
          height: fieldSpacing,
        ),
        SizedBox(
          height: 56,
          width: double.infinity,
          child: _loginButton,
        )
      ],
    );
  }
}

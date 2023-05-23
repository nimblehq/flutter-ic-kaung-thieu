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

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isFormSubmitted = false;

  AppLocalizations get _localizations => AppLocalizations.of(context)!;

  TextTheme get _textTheme => Theme.of(context).textTheme;

  TextFormField get _emailTextField => TextFormField(
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        decoration: FormFieldDecoration(
          hint: _localizations.emailInputHint,
          hintTextStyle: _textTheme.bodyMedium,
        ),
        style: _textTheme.bodyMedium,
        validator: (value) => ref
            .read(loginViewModelProvider.notifier)
            .checkEmail(value, _localizations.invalidEmailError),
        autovalidateMode: _isFormSubmitted
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
      );

  TextFormField get _passwordTextField => TextFormField(
        autocorrect: false,
        obscureText: true,
        decoration: FormFieldDecoration(
          hint: _localizations.passwordInputHint,
          hintTextStyle: _textTheme.bodyMedium,
        ),
        style: _textTheme.bodyMedium,
        validator: (value) => ref
            .read(loginViewModelProvider.notifier)
            .checkPassword(value, _localizations.invalidPasswordError),
        autovalidateMode: _isFormSubmitted
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
      );

  ElevatedButton get _loginButton => ElevatedButton(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: Colors.red)),
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
    setState(() {
      _isFormSubmitted = true;
    });
    KeyboardManager.dismiss(context);
    if (_formKey.currentState!.validate()) {
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
    return Form(
      key: _formKey,
      child: Column(
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
      ),
    );
  }
}

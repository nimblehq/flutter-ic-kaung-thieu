import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:survey_flutter/screens/widgets/alert_dialog.dart';
import 'package:survey_flutter/screens/widgets/form_field_decoration.dart';
import 'package:survey_flutter/theme/constant.dart';
import 'package:survey_flutter/utils/keyboard_manager.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
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
        validator: _emailValidator,
        autovalidateMode: _isFormSubmitted
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
      );

  TextFormField get _passwordTextField => TextFormField(
        autocorrect: false,
        obscureText: true,
        decoration: FormFieldDecoration(
          hint: _localizations.passwordInputHint,
          hintTextStyle: _textTheme.bodyLarge,
        ),
        style: _textTheme.bodyLarge,
        validator: _passwordValidator,
        autovalidateMode: _isFormSubmitted
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
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
        child: Text(_localizations.loginButton),
      );

  // TODO: Move the validation logic to the ViewModel
  // upon implementing Integration task
  String? _emailValidator(String? email) {
    // Just use a simple rule, no need complex Regex!
    if (email == null || email.isEmpty || !email.contains('@')) {
      return _localizations.invalidEmailError;
    }
    return null;
  }

  String? _passwordValidator(String? password) {
    if (password == null || password.isEmpty || password.length < 8) {
      return _localizations.invalidPasswordError;
    }
    return null;
  }

  bool _isFormSubmitted = false;

  void _submitForm() {
    setState(() => _isFormSubmitted = true);

    if (_formKey.currentState!.validate()) {
      KeyboardManager.dismiss(context);
      // TODO - implement login
      showAlertDialog(
          context: context,
          title: _localizations.loginFailAlertTitle,
          message: _localizations.loginFailAlertMessage,
          actions: [
            TextButton(
              child: Text(_localizations.okText),
              onPressed: () => Navigator.pop(context),
            ),
          ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    const fieldSpacing = 20.0;
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

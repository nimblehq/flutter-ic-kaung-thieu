import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/model/login_parameters.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/login_use_case.dart';

final loginViewModelProvider =
    AsyncNotifierProvider.autoDispose<LoginViewModel, void>(LoginViewModel.new);

class LoginViewModel extends AutoDisposeAsyncNotifier<void> {
  late LoginUseCase loginUseCase;

  String _email = '';
  String _password = '';

  final _isValidEmail = StreamController<bool>();
  Stream<bool> get isValidEmail => _isValidEmail.stream;

  final _isValidPassword = StreamController<bool>();
  Stream<bool> get isValidPassword => _isValidPassword.stream;

  void checkEmail(String? email) {
    _email = email ?? '';
    _isValidEmail
        .add(!(email == null || email.isEmpty || !email.contains('@')));
  }

  void checkPassword(String? password) {
    _password = password ?? '';
    _isValidPassword
        .add(!(password == null || password.isEmpty || password.length < 8));
  }

  @override
  FutureOr<void> build() {
    ref.onDispose(() {
      _isValidPassword.close();
      _isValidEmail.close();
    });
  }

  login() async {
    state = const AsyncLoading();
    loginUseCase = ref.read(loginUseCaseProvider);
    final result = await loginUseCase(
      LoginParameters(
        email: _email,
        password: _password,
      ),
    );
    if (result is Success) {
      state = const AsyncData(null);
    } else {
      final error = result as Failed;
      state = AsyncError(
          error.getErrorMessage(useCustomMessage: true), StackTrace.empty);
    }
  }
}

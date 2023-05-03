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

  bool isValidEmail(String? email) {
    _email = email ?? '';
    return !(email == null || email.isEmpty || !email.contains('@'));
  }

  bool isValidPassword(String? password) {
    _password = password ?? '';
    return !(password == null || password.isEmpty || password.length < 8);
  }

  @override
  FutureOr<void> build() {}

  login() async {
    loginUseCase = ref.read(loginUseCaseProvider);
    state = const AsyncLoading();
    final result = await loginUseCase.call(
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

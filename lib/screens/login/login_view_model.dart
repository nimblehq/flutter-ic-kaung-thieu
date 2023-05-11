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

  String? checkEmail(String? email, String errorMessage) {
    _email = email ?? '';
    if (email == null || email.isEmpty || !email.contains('@')) {
      return errorMessage;
    }
    return null;
  }

  String? checkPassword(String? password, String errorMessage) {
    _password = password ?? '';
    if (password == null || password.isEmpty || password.length < 8) {
      return errorMessage;
    }
    return null;
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

  @override
  FutureOr<void> build() {}
}

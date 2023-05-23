import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/storage/shared_preference.dart';

final splashViewModelProvider =
    AsyncNotifierProvider.autoDispose<SplashViewModel, void>(
        SplashViewModel.new);

class SplashViewModel extends AutoDisposeAsyncNotifier<void> {
  final _isAlreadyLoggedIn = StreamController<bool>();
  Stream<bool> get isAlreadyLoggedIn => _isAlreadyLoggedIn.stream;

  void _checkIfUserAlreadyLoggedIn() async {
    final sharedPreference = ref.read(sharedPreferenceProvider);
    final result = await sharedPreference.isAlreadyLoggedIn();
    _isAlreadyLoggedIn.add(result);
  }

  @override
  FutureOr<void> build() {
    _checkIfUserAlreadyLoggedIn();
    ref.onDispose(() async {
      await _isAlreadyLoggedIn.close();
    });
  }
}

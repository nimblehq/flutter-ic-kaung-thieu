import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/api/storage/shared_preference.dart';
import 'package:survey_flutter/screens/splash/splash_view_model.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  final MockSharedPreference mockSharedPreference = MockSharedPreference();

  late ProviderContainer container;

  setUp(() {
    final providerContainer = ProviderContainer(overrides: [
      sharedPreferenceProvider.overrideWithValue(mockSharedPreference),
    ]);
    container = providerContainer;
  });

  tearDown(() => container.dispose());

  group('SplashViewModel', () {
    test('When isAlreadyLoggedIn of SharedPreference is true, it emits true',
        () async {
      when(mockSharedPreference.isAlreadyLoggedIn())
          .thenAnswer((_) async => true);

      final viewModel = container.read(splashViewModelProvider.notifier);

      expect(viewModel.isAlreadyLoggedIn, emits(true));
    });

    test('When isAlreadyLoggedIn of SharedPreference is false, it emits false',
        () async {
      when(mockSharedPreference.isAlreadyLoggedIn())
          .thenAnswer((_) async => false);

      final viewModel = container.read(splashViewModelProvider.notifier);

      expect(viewModel.isAlreadyLoggedIn, emits(false));
    });
  });
}

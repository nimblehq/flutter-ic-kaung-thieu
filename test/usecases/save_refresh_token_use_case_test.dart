import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/save_refresh_token_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('Save Refresh Token Use Case', () {
    MockSharedPreferenceRepository mockSharedPreferenceRepository =
        MockSharedPreferenceRepository();

    late SaveRefreshTokenUseCase useCase;

    setUp(() =>
        useCase = SaveRefreshTokenUseCase(mockSharedPreferenceRepository));

    test('When save refreshToken, it emits success', () async {
      when(
        mockSharedPreferenceRepository.saveRefreshToken('refreshToken'),
      ).thenAnswer((_) => Future.value());

      final result = await useCase.call('refreshToken');
      expect(result is Success, true);
    });
  });
}

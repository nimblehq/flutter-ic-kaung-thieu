import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/get_refresh_token_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('Get Refresh Token Use Case', () {
    MockSharedPreferenceRepository mockSharedPreferenceRepository =
        MockSharedPreferenceRepository();

    late GetRefreshTokenUseCase useCase;
    setUp(
      () => useCase = GetRefreshTokenUseCase(mockSharedPreferenceRepository),
    );

    test('When get refreshToken, it emits success with correct data', () async {
      when(mockSharedPreferenceRepository.getRefreshToken())
          .thenAnswer((_) async => 'refreshToken');

      final result = await useCase.call(null);
      expect(result is Success<String?>, true);
      final resultData = (result as Success<String?>).value;
      expect(
        resultData,
        'refreshToken',
      );
    });
  });
}

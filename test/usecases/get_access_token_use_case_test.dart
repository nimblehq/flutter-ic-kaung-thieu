import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/get_access_token_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('Get Access Token Use Case', () {
    MockSharedPreferenceRepository mockSharedPreferenceRepository =
        MockSharedPreferenceRepository();

    late GetAccessTokenUseCase useCase;
    setUp(
      () => useCase = GetAccessTokenUseCase(mockSharedPreferenceRepository),
    );

    test('When get accessToken, it emits success with correct data', () async {
      when(mockSharedPreferenceRepository.getAccessToken())
          .thenAnswer((_) async => 'accessToken');

      final result = await useCase.call(null);
      expect(result is Success<String?>, true);
      final resultData = (result as Success<String?>).value;
      expect(
        resultData,
        'accessToken',
      );
    });
  });
}

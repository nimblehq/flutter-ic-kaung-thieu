import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/save_access_token_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('Save Access Token Use Case', () {
    MockSharedPreferenceRepository mockSharedPreferenceRepository =
        MockSharedPreferenceRepository();

    late SaveAccessTokenUseCase useCase;

    setUp(
        () => useCase = SaveAccessTokenUseCase(mockSharedPreferenceRepository));

    test('When save accessToken, it emits success', () async {
      when(
        mockSharedPreferenceRepository.saveAccessToken('accessToken'),
      ).thenAnswer((_) => Future.value());

      final result = await useCase.call('accessToken');
      expect(result is Success, true);
    });
  });
}

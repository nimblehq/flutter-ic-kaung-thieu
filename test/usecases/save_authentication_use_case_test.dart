import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/save_authentication_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';
import '../mocks/mock_util.dart';

void main() {
  group('Save Authentication Use Case', () {
    MockSharedPreferenceRepository mockSharedPreferenceRepository =
        MockSharedPreferenceRepository();

    late SaveAuthenticationUseCase useCase;

    setUp(() =>
        useCase = SaveAuthenticationUseCase(mockSharedPreferenceRepository));

    test('When save authentication, it emits success', () async {
      when(
        mockSharedPreferenceRepository.saveAuthentication(
          authenticationModel: anyNamed('authenticationModel'),
        ),
      ).thenAnswer((_) => Future.value());

      final result = await useCase.call(MockUtil.authenticationParameters);
      expect(result is Success, true);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/model/authentication_parameters.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/get_authentication_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';
import '../mocks/mock_util.dart';

void main() {
  group('Get Authentication Use Case', () {
    MockSharedPreferenceRepository mockSharedPreferenceRepository =
        MockSharedPreferenceRepository();

    late GetAuthenticationUseCase useCase;

    setUp(
      () => useCase = GetAuthenticationUseCase(mockSharedPreferenceRepository),
    );

    test('When get saved authentication, it emits success with correct data',
        () async {
      when(mockSharedPreferenceRepository.getSavedAuthentication())
          .thenAnswer((_) async => MockUtil.authenticationParameters);

      final result = await useCase.call(null);
      expect(result is Success<AuthenticationParameters>, true);
      final resultData = (result as Success<AuthenticationParameters>).value;
      expect(
        resultData.refreshToken,
        MockUtil.authenticationParameters.refreshToken,
      );
      expect(
        resultData.tokenType,
        MockUtil.authenticationParameters.tokenType,
      );
      expect(
        resultData.accessToken,
        MockUtil.authenticationParameters.accessToken,
      );
    });
  });
}

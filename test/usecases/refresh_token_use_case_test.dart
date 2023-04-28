import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/refresh_token_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';
import '../mocks/mock_util.dart';

void main() {
  group('RefreshTokenUseCase', () {
    MockAuthRepository mockAuthRepository = MockAuthRepository();

    late RefreshTokenUseCase refreshTokenUseCase;

    setUp(() => refreshTokenUseCase = RefreshTokenUseCase(mockAuthRepository));

    test('When refresh with refreshToken, it emits success', () async {
      when(mockAuthRepository.refreshToken())
          .thenAnswer((realInvocation) async => MockUtil.loginResponse);

      final result = await refreshTokenUseCase.call();
      expect(result is Success, true);
    });

    test('When refresh with incorrect refreshToken, it emits failed', () async {
      when(mockAuthRepository.refreshToken()).thenThrow(MockDioError());

      final result = await refreshTokenUseCase.call();
      expect(result is Failed, true);
    });
  });
}

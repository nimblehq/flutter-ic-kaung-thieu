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

    test('When calling the use case successfully, it emits success result',
        () async {
      when(mockAuthRepository.refreshToken())
          .thenAnswer((realInvocation) async => MockUtil.loginDataResponse);

      final result = await refreshTokenUseCase.call();
      expect(result is Success, true);
    });

    test('When calling the use case unsuccessfully, it emits failed result',
        () async {
      when(mockAuthRepository.refreshToken()).thenThrow(MockDioError());

      final result = await refreshTokenUseCase.call();
      expect(result is Failed, true);
    });
  });
}

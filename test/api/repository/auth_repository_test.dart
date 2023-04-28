import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/api/repository/auth_repository.dart';

import '../../mocks/generate_mocks.mocks.dart';
import '../../mocks/mock_util.dart';

void main() {
  group('AuthRepository', () {
    MockApiService mockApiService = MockApiService();
    MockSharedPreference mockSharedPreference = MockSharedPreference();
    FlutterConfigPlus.loadValueForTesting({
      'CLIENT_ID': MockUtil.loginRequest.clientId,
      'CLIENT_SECRET': MockUtil.loginRequest.clientSecret,
    });

    late AuthRepository repository;

    setUp(
      () => repository = AuthRepositoryImpl(
        mockApiService,
        mockSharedPreference,
      ),
    );

    test('When refresh with refreshToken, it save corresponding result',
        () async {
      when(mockApiService.refreshToken(any))
          .thenAnswer((_) async => MockUtil.loginResponse);
      when(mockSharedPreference.getRefreshToken())
          .thenAnswer((realInvocation) async => 'refreshToken');

      await repository.refreshToken();
      verify(
        mockSharedPreference
            .saveAccessToken(MockUtil.loginAttributeResponse.accessToken),
      ).called(1);
      verify(
        mockSharedPreference
            .saveRefreshToken(MockUtil.loginAttributeResponse.refreshToken),
      ).called(1);
    });

    test(
      'When refresh with incorrect refreshToken, it throws NetworkExceptions error',
      () async {
        when(mockApiService.refreshToken(any)).thenThrow(MockDioError());

        expect(
          () => repository.refreshToken(),
          throwsA(isA<NetworkExceptions>()),
        );
      },
    );
  });
}

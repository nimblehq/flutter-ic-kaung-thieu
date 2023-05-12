import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/api/repository/login_repository.dart';

import '../../mocks/generate_mocks.mocks.dart';
import '../../mocks/mock_util.dart';

void main() {
  group('LoginRepository', () {
    MockApiService mockApiService = MockApiService();
    MockSharedPreference mockSharedPreference = MockSharedPreference();

    FlutterConfigPlus.loadValueForTesting({
      'CLIENT_ID': MockUtil.loginRequest.clientId,
      'CLIENT_SECRET': MockUtil.loginRequest.clientSecret,
    });
    late LoginRepository repository;

    setUp(
      () => repository = LoginRepositoryImpl(
        mockApiService,
        mockSharedPreference,
      ),
    );

    test(
      'When login with correct email and password, it emits corresponding response',
      () async {
        when(mockApiService.logIn(any))
            .thenAnswer((_) async => MockUtil.loginResponse);

        final result = await repository.login(
            email: MockUtil.loginRequest.email,
            password: MockUtil.loginRequest.password);
        expect(result.id, MockUtil.loginResponse.id);
      },
    );

    test(
      'When login with incorrect email or password, it throws NetworkExceptions error',
      () async {
        when(mockApiService.logIn(any)).thenThrow(MockDioError());

        expect(
          () => repository.login(
              email: MockUtil.loginRequest.email,
              password: MockUtil.loginRequest.password),
          throwsA(isA<NetworkExceptions>()),
        );
      },
    );

    test(
        'When calling refreshToken successfully, it saves the corresponding result',
        () async {
      when(mockApiService.refreshToken(any))
          .thenAnswer((_) async => MockUtil.loginDataResponse);
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
      verify(
        mockSharedPreference
            .saveTokenType(MockUtil.loginAttributeResponse.tokenType),
      ).called(1);
    });

    test(
      'When calling refreshToken unsuccessfully, it throws the NetworkExceptions error',
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

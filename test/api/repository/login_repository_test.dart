import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/api/repository/login_repository.dart';

import '../../mocks/generate_mocks.mocks.dart';
import '../../mocks/mock_util.dart';

void main() {
  group('LoginRepository', () {
    MockApiService mockApiService = MockApiService();
    FlutterConfig.loadValueForTesting({
      'CLIENT_ID': MockUtil.loginRequest.clientId,
      'CLIENT_SECRET': MockUtil.loginRequest.clientSecret,
    });
    late LoginRepository repository;

    setUp(() => repository = LoginRepositoryImpl(mockApiService));

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
  });
}

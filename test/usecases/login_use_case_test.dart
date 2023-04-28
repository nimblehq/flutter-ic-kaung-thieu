import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/model/login_parameters.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/login_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';
import '../mocks/mock_util.dart';

void main() {
  group('Login Use Case', () {
    MockLoginRepository mockLoginRepository = MockLoginRepository();

    late LoginUseCase loginUseCase;

    setUp(() => loginUseCase = LoginUseCase(mockLoginRepository));
    test(
      'When login with correct email and password, it emits success',
      () async {
        when(mockLoginRepository.login(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => MockUtil.loginResponse);

        final result = await loginUseCase.call(const LoginParameters(
            email: 'test@gmail.com', password: 'password'));
        expect(result is Success, true);
      },
    );

    test(
      'When login with incorrect email and password, it emits failed',
      () async {
        when(mockLoginRepository.login(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenThrow(MockDioError());

        final result = await loginUseCase.call(const LoginParameters(
            email: 'test@gmail.com', password: 'password'));
        expect(result is Failed, true);
      },
    );
  });
}

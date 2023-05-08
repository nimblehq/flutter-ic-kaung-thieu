import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/model/login_parameters.dart';
import 'package:survey_flutter/screens/login/login_view_model.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/login_use_case.dart';

import '../../mocks/generate_mocks.mocks.dart';
import '../../mocks/mock_util.dart';

void main() {
  final MockLoginUseCase mockLoginUseCase = MockLoginUseCase();
  final MockAsyncListener mockListener = MockAsyncListener();

  late ProviderContainer container;

  setUp(() {
    final providerContainer = ProviderContainer(overrides: [
      loginUseCaseProvider.overrideWithValue(mockLoginUseCase),
    ]);
    container = providerContainer;
    container.listen(
      loginViewModelProvider,
      mockListener,
      fireImmediately: true,
    );
  });

  setUpAll(() {});

  tearDown(() => container.dispose());

  group('LoginViewModel', () {
    test('Initial state is AsyncData', () {
      verify(
        // the build method returns a value immediately, so we expect AsyncData
        mockListener.call(null, const AsyncData<void>(null)),
      );
      verifyNoMoreInteractions(mockListener);
      verifyNever(
        mockLoginUseCase(
          const LoginParameters(email: 'email', password: 'password'),
        ),
      );
    });

    test(
        'When calling login successfully, it emits loading and data correspondingly',
        () async {
      when(mockLoginUseCase.call(any))
          .thenAnswer((_) async => Success(MockUtil.loginDataResponse));

      const data = AsyncData<void>(null);
      // verify initial value from build method
      verify(mockListener(null, data));
      final viewModel = container.read(loginViewModelProvider.notifier);

      viewModel.checkEmail('example@gmail.com');
      viewModel.checkPassword('12345678');
      await viewModel.login();

      verifyInOrder([
        mockListener(data, isA<AsyncLoading<void>>()),
        mockListener(isA<AsyncLoading<void>>(), data),
      ]);
      verifyNoMoreInteractions(mockListener);
    });

    test(
        'When calling login unsuccessfully, it emits loading and error correspondingly',
        () async {
      final exception =
          UseCaseException(const NetworkExceptions.unauthorisedRequest());
      when(mockLoginUseCase.call(any))
          .thenAnswer((_) async => Failed(exception));

      const data = AsyncData<void>(null);
      // verify initial value from build method
      verify(mockListener(null, data));
      final viewModel = container.read(loginViewModelProvider.notifier);

      viewModel.checkEmail('invalid@gmail.com');
      viewModel.checkPassword('invalid');
      await viewModel.login();

      verifyInOrder([
        mockListener(data, isA<AsyncLoading<void>>()),
        mockListener(isA<AsyncLoading<void>>(), isA<AsyncError<void>>()),
      ]);
      verifyNoMoreInteractions(mockListener);
    });
  });
}

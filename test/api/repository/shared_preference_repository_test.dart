import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/api/repository/shared_preference_repository.dart';

import '../../mocks/generate_mocks.mocks.dart';
import '../../mocks/mock_util.dart';

void main() {
  group('SharedPreferenceRepository', () {
    MockFlutterSecureStorage mockFlutterSecureStorage =
        MockFlutterSecureStorage();
    late SharedPreferenceRepository repository;

    setUp(() =>
        repository = SharedPreferenceRepositoryImpl(mockFlutterSecureStorage));

    test(
      'When save authentication, it stores with correct data',
      () async {
        await repository.saveAuthentication(
            authenticationModel: MockUtil.authenticationParameters);

        verify(
          mockFlutterSecureStorage.write(
            key: accessTokenKey,
            value: MockUtil.authenticationParameters.accessToken,
            aOptions: (repository as SharedPreferenceRepositoryImpl)
                .getAndroidOptions(),
            iOptions:
                (repository as SharedPreferenceRepositoryImpl).getIOSOptions(),
          ),
        ).called(1);

        verify(
          mockFlutterSecureStorage.write(
            key: refreshTokenKey,
            value: MockUtil.authenticationParameters.refreshToken,
            aOptions: (repository as SharedPreferenceRepositoryImpl)
                .getAndroidOptions(),
            iOptions:
                (repository as SharedPreferenceRepositoryImpl).getIOSOptions(),
          ),
        ).called(1);

        verify(
          mockFlutterSecureStorage.write(
            key: tokenTypeKey,
            value: MockUtil.authenticationParameters.tokenType,
            aOptions: (repository as SharedPreferenceRepositoryImpl)
                .getAndroidOptions(),
            iOptions:
                (repository as SharedPreferenceRepositoryImpl).getIOSOptions(),
          ),
        ).called(1);
      },
    );

    test(
      'When get saved authentication result, it return correct data',
      () async {
        when(mockFlutterSecureStorage.read(key: accessTokenKey)).thenAnswer(
            (_) async => MockUtil.authenticationParameters.accessToken);
        when(mockFlutterSecureStorage.read(key: refreshTokenKey)).thenAnswer(
            (_) async => MockUtil.authenticationParameters.refreshToken);
        when(mockFlutterSecureStorage.read(key: tokenTypeKey)).thenAnswer(
            (_) async => MockUtil.authenticationParameters.tokenType);

        final result = await repository.getSavedAuthentication();
        expect(
            result.accessToken, MockUtil.authenticationParameters.accessToken);
        expect(result.refreshToken,
            MockUtil.authenticationParameters.refreshToken);
        expect(result.tokenType, MockUtil.authenticationParameters.tokenType);
      },
    );

    test(
      'When get saved authentication result without saving anything ahead, it return blank data',
      () async {
        when(mockFlutterSecureStorage.read(key: accessTokenKey))
            .thenAnswer((_) async => null);
        when(mockFlutterSecureStorage.read(key: refreshTokenKey))
            .thenAnswer((_) async => null);
        when(mockFlutterSecureStorage.read(key: tokenTypeKey))
            .thenAnswer((_) async => null);

        final result = await repository.getSavedAuthentication();
        expect(result.accessToken, '');
        expect(result.refreshToken, '');
        expect(result.tokenType, '');
      },
    );
  });
}

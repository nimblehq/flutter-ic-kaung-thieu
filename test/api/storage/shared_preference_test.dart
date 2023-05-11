import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/api/storage/shared_preference.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('SharedPreferenceRepository', () {
    MockFlutterSecureStorage mockFlutterSecureStorage =
        MockFlutterSecureStorage();
    late SharedPreference repository;

    setUp(() => repository = SharedPreferenceImpl(mockFlutterSecureStorage));

    test(
      'When save accessToken, it stores with correct data',
      () async {
        await repository.saveAccessToken('accessToken');

        verify(
          mockFlutterSecureStorage.write(
            key: accessTokenKey,
            value: 'accessToken',
            aOptions: (repository as SharedPreferenceImpl).getAndroidOptions(),
            iOptions: (repository as SharedPreferenceImpl).getIOSOptions(),
          ),
        ).called(1);
      },
    );

    test(
      'When save refreshToken, it stores with correct data',
      () async {
        await repository.saveRefreshToken('refreshToken');

        verify(
          mockFlutterSecureStorage.write(
            key: refreshTokenKey,
            value: 'refreshToken',
            aOptions: (repository as SharedPreferenceImpl).getAndroidOptions(),
            iOptions: (repository as SharedPreferenceImpl).getIOSOptions(),
          ),
        ).called(1);
      },
    );

    test(
      'When save tokenType, it stores with correct data',
      () async {
        await repository.saveTokenType('tokenType');

        verify(
          mockFlutterSecureStorage.write(
            key: tokenTypeKey,
            value: 'tokenType',
            aOptions: (repository as SharedPreferenceImpl).getAndroidOptions(),
            iOptions: (repository as SharedPreferenceImpl).getIOSOptions(),
          ),
        ).called(1);
      },
    );

    test(
      'When get saved accessToken, it return correct data',
      () async {
        when(mockFlutterSecureStorage.read(key: accessTokenKey))
            .thenAnswer((_) async => 'accessToken');

        final result = await repository.getAccessToken();
        expect(result, 'accessToken');
      },
    );

    test(
      'When get saved refreshToken, it return correct data',
      () async {
        when(mockFlutterSecureStorage.read(key: refreshTokenKey))
            .thenAnswer((_) async => 'refreshToken');

        final result = await repository.getRefreshToken();
        expect(result, 'refreshToken');
      },
    );

    test(
      'When get saved tokenType, it return correct data',
      () async {
        when(mockFlutterSecureStorage.read(key: tokenTypeKey))
            .thenAnswer((_) async => 'tokenType');

        final result = await repository.getTokenType();
        expect(result, 'tokenType');
      },
    );

    test(
      'When get unsaved accessToken, it return null',
      () async {
        when(mockFlutterSecureStorage.read(key: accessTokenKey))
            .thenAnswer((_) async => null);

        final result = await repository.getAccessToken();
        expect(result, null);
      },
    );

    test(
      'When get unsaved refreshToken, it return null',
      () async {
        when(mockFlutterSecureStorage.read(key: refreshTokenKey))
            .thenAnswer((_) async => null);

        final result = await repository.getRefreshToken();
        expect(result, null);
      },
    );

    test(
      'When get unsaved tokenType, it return null',
      () async {
        when(mockFlutterSecureStorage.read(key: tokenTypeKey))
            .thenAnswer((_) async => null);

        final result = await repository.getTokenType();
        expect(result, null);
      },
    );

    test(
      'When there is no saved accessToken, isAlreadyLoggedIn return false',
      () async {
        when(mockFlutterSecureStorage.read(key: accessTokenKey))
            .thenAnswer((_) async => null);

        final result = await repository.isAlreadyLoggedIn();
        expect(result, false);
      },
    );

    test(
      'When there is saved accessToken, isAlreadyLoggedIn return true',
      () async {
        when(mockFlutterSecureStorage.read(key: accessTokenKey))
            .thenAnswer((_) async => 'accessToken');

        final result = await repository.isAlreadyLoggedIn();
        expect(result, true);
      },
    );
  });
}

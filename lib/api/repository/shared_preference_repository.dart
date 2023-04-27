import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:survey_flutter/di/provider/flutter_secure_storage_provider.dart';
import 'package:survey_flutter/model/authentication_parameters.dart';

const String accessTokenKey = 'access_token';
const String tokenTypeKey = 'token_type';
const String refreshTokenKey = 'refresh_token';

final sharedPreferenceRepositoryProvider = Provider((ref) {
  return SharedPreferenceRepositoryImpl(
    FlutterSecureStorageProvider().getFlutterSecureStorage(),
  );
});

abstract class SharedPreferenceRepository {
  Future<void> saveAuthentication(
      {required AuthenticationParameters authenticationModel});

  Future<AuthenticationParameters> getSavedAuthentication();
}

class SharedPreferenceRepositoryImpl extends SharedPreferenceRepository {
  final FlutterSecureStorage _storage;

  SharedPreferenceRepositoryImpl(this._storage);

  IOSOptions getIOSOptions() => const IOSOptions(
        accountName: 'flutter_secure_storage_service',
      );

  AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  @override
  Future<void> saveAuthentication(
      {required AuthenticationParameters authenticationModel}) async {
    await _storage.write(
      key: accessTokenKey,
      value: authenticationModel.accessToken,
      iOptions: getIOSOptions(),
      aOptions: getAndroidOptions(),
    );

    await _storage.write(
      key: tokenTypeKey,
      value: authenticationModel.tokenType,
      iOptions: getIOSOptions(),
      aOptions: getAndroidOptions(),
    );

    await _storage.write(
      key: refreshTokenKey,
      value: authenticationModel.refreshToken,
      iOptions: getIOSOptions(),
      aOptions: getAndroidOptions(),
    );
  }

  @override
  Future<AuthenticationParameters> getSavedAuthentication() async {
    return AuthenticationParameters(
      accessToken: await _storage.read(key: accessTokenKey) ?? '',
      tokenType: await _storage.read(key: tokenTypeKey) ?? '',
      refreshToken: await _storage.read(key: refreshTokenKey) ?? '',
    );
  }
}

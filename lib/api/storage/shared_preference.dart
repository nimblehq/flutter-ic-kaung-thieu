import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:survey_flutter/di/provider/flutter_secure_storage_provider.dart';

const String accessTokenKey = 'access_token';
const String tokenTypeKey = 'token_type';
const String refreshTokenKey = 'refresh_token';

final sharedPreferenceProvider = Provider((ref) {
  return SharedPreferenceImpl(
    FlutterSecureStorageProvider().getFlutterSecureStorage(),
  );
});

abstract class SharedPreference {
  Future<void> saveAccessToken(String accessToken);

  Future<void> saveTokenType(String tokenType);

  Future<void> saveRefreshToken(String refreshToken);

  Future<String?> getAccessToken();

  Future<String?> getTokenType();

  Future<String?> getRefreshToken();

  Future<bool> isAlreadyLoggedIn();
}

class SharedPreferenceImpl extends SharedPreference {
  final FlutterSecureStorage _storage;

  SharedPreferenceImpl(this._storage);

  IOSOptions getIOSOptions() => const IOSOptions(
        accountName: 'flutter_secure_storage_service',
      );

  AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  @override
  Future<String?> getAccessToken() async {
    return await _storage.read(key: accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: refreshTokenKey);
  }

  @override
  Future<String?> getTokenType() async {
    return await _storage.read(key: tokenTypeKey);
  }

  @override
  Future<void> saveAccessToken(String accessToken) async {
    await _storage.write(
      key: accessTokenKey,
      value: accessToken,
      iOptions: getIOSOptions(),
      aOptions: getAndroidOptions(),
    );
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    await _storage.write(
      key: refreshTokenKey,
      value: refreshToken,
      iOptions: getIOSOptions(),
      aOptions: getAndroidOptions(),
    );
  }

  @override
  Future<void> saveTokenType(String tokenType) async {
    await _storage.write(
      key: tokenTypeKey,
      value: tokenType,
      iOptions: getIOSOptions(),
      aOptions: getAndroidOptions(),
    );
  }

  @override
  Future<bool> isAlreadyLoggedIn() async {
    final accessToken = await _storage.read(key: accessTokenKey);
    return accessToken?.isNotEmpty ?? false;
  }
}

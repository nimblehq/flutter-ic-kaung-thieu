import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/api_service.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/api/storage/shared_preference.dart';
import 'package:survey_flutter/di/provider/dio_provider.dart';
import 'package:survey_flutter/model/request/auth_request.dart';

const String _grantType = 'refresh_token';

final authRepositoryProvider = Provider((ref) {
  return AuthRepositoryImpl(
    ApiService(DioProvider().getDioUnauthorized()),
    ref.watch(sharedPreferenceProvider),
  );
});

abstract class AuthRepository {
  Future<void> refreshToken();
}

class AuthRepositoryImpl extends AuthRepository {
  final ApiService _apiService;
  final SharedPreference _sharedPreference;

  AuthRepositoryImpl(
    this._apiService,
    this._sharedPreference,
  );

  @override
  Future<void> refreshToken() async {
    try {
      final refreshToken = await _sharedPreference.getRefreshToken() ?? '';
      final result = await _apiService.refreshToken(
        AuthRequest(
          grantType: _grantType,
          refreshToken: refreshToken,
          clientId: FlutterConfigPlus.get('CLIENT_ID'),
          clientSecret: FlutterConfigPlus.get('CLIENT_SECRET'),
        ),
      );
      await _sharedPreference.saveRefreshToken(
          result.loginResponse?.loginAttributeResponse?.refreshToken ?? '');
      await _sharedPreference.saveAccessToken(
          result.loginResponse?.loginAttributeResponse?.accessToken ?? '');
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}

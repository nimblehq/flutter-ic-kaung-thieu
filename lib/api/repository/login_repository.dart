import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/api_service.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/api/storage/shared_preference.dart';
import 'package:survey_flutter/di/provider/dio_provider.dart';
import 'package:survey_flutter/model/request/auth_request.dart';
import 'package:survey_flutter/model/request/login_request.dart';
import 'package:survey_flutter/model/response/login_response.dart';

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  return LoginRepositoryImpl(
    ApiService(DioProvider().getDioUnauthorized()),
    ref.watch(sharedPreferenceProvider),
  );
});

abstract class LoginRepository {
  Future<LoginResponse> login(
      {required String email, required String password});

  Future<void> refreshToken();
}

class LoginRepositoryImpl extends LoginRepository {
  final ApiService _apiService;
  final SharedPreference _sharedPreference;

  LoginRepositoryImpl(
    this._apiService,
    this._sharedPreference,
  );

  final String _grantType = 'password';

  @override
  Future<LoginResponse> login(
      {required String email, required String password}) async {
    try {
      return await _apiService.logIn(LoginRequest(
        grantType: _grantType,
        email: email,
        password: password,
        clientId: FlutterConfigPlus.get('CLIENT_ID'),
        clientSecret: FlutterConfigPlus.get('CLIENT_SECRET'),
      ));
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }

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
      final attribute = result.loginResponse?.loginAttributeResponse;
      await _sharedPreference.saveRefreshToken(attribute?.refreshToken ?? '');
      await _sharedPreference.saveAccessToken(attribute?.accessToken ?? '');
      await _sharedPreference.saveTokenType(attribute?.tokenType ?? '');
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}

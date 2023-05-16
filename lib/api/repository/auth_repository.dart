import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/api_service.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/api/storage/shared_preference.dart';
import 'package:survey_flutter/di/provider/dio_provider.dart';
import 'package:survey_flutter/model/request/auth_request.dart';
import 'package:survey_flutter/model/request/login_request.dart';
import 'package:survey_flutter/model/response/login_data_response.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    apiService: ApiService(DioProvider().getDioUnauthorized()),
    sharedPreference: ref.watch(sharedPreferenceProvider),
  );
});

abstract class AuthRepository {
  Future<LoginDataResponse> login(
      {required String email, required String password});

  Future<void> refreshToken();
}

class AuthRepositoryImpl extends AuthRepository {
  final ApiService _apiService;
  final SharedPreference _sharedPreference;

  AuthRepositoryImpl({
    required ApiService apiService,
    required SharedPreference sharedPreference,
  })  : _apiService = apiService,
        _sharedPreference = sharedPreference;

  final String _grantType = 'password';

  @override
  Future<LoginDataResponse> login(
      {required String email, required String password}) async {
    try {
      final result = await _apiService.logIn(LoginRequest(
        grantType: _grantType,
        email: email,
        password: password,
        clientId: FlutterConfigPlus.get('CLIENT_ID'),
        clientSecret: FlutterConfigPlus.get('CLIENT_SECRET'),
      ));
      final loginAttribute = result.loginResponse;
      await _sharedPreference
          .saveRefreshToken(loginAttribute?.refreshToken ?? '');
      await _sharedPreference
          .saveAccessToken(loginAttribute?.accessToken ?? '');
      await _sharedPreference.saveTokenType(loginAttribute?.tokenType ?? '');
      return result;
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
      final attribute = result.loginResponse;
      await _sharedPreference.saveRefreshToken(attribute?.refreshToken ?? '');
      await _sharedPreference.saveAccessToken(attribute?.accessToken ?? '');
      await _sharedPreference.saveTokenType(attribute?.tokenType ?? '');
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}

import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/api_service.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/di/provider/dio_provider.dart';
import 'package:survey_flutter/model/request/login_request.dart';
import 'package:survey_flutter/model/response/login_response.dart';

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  return LoginRepositoryImpl(ApiService(DioProvider().getDio()));
});

abstract class LoginRepository {
  Future<LoginResponse> login(
      {required String email, required String password});
}

class LoginRepositoryImpl extends LoginRepository {
  final ApiService _apiService;

  LoginRepositoryImpl(this._apiService);

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
}

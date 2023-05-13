import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:survey_flutter/api/storage/shared_preference.dart';
import 'package:survey_flutter/di/interceptor/app_interceptor.dart';
import 'package:survey_flutter/env.dart';
import 'package:survey_flutter/usecases/refresh_token_use_case.dart';

const String headerContentType = 'Content-Type';
const String defaultContentType = 'application/json; charset=utf-8';

class DioProvider {
  Dio? _dio;
  SharedPreference? _sharedPreference;
  RefreshTokenUseCase? _refreshTokenUseCase;

  Dio getDioAuthorized({
    required SharedPreference sharedPreference,
    required RefreshTokenUseCase refreshTokenUseCase,
  }) {
    _sharedPreference = sharedPreference;
    _refreshTokenUseCase = refreshTokenUseCase;
    _dio ??= _createDio(requireAuthenticate: true);
    return _dio!;
  }

  Dio getDioUnauthorized() {
    _dio ??= _createDio();
    return _dio!;
  }

  Dio _createDio({bool requireAuthenticate = false}) {
    final dio = Dio();
    final appInterceptor =
        AppInterceptor(requireAuthenticate, dio, _sharedPreference, _refreshTokenUseCase);
    final interceptors = <Interceptor>[];
    interceptors.add(appInterceptor);
    if (!kReleaseMode) {
      // Debug Mode
      interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ));
    }

    return dio
      ..options.connectTimeout = const Duration(seconds: 3)
      ..options.receiveTimeout = const Duration(seconds: 5)
      ..options.headers = {headerContentType: defaultContentType}
      ..interceptors.addAll(interceptors)
      ..options.baseUrl = Env.restApiEndpoint;
  }
}

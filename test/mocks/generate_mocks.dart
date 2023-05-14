import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:survey_flutter/api/api_service.dart';
import 'package:mockito/annotations.dart';
import 'package:survey_flutter/api/repository/auth_repository.dart';
import 'package:survey_flutter/api/repository/home_repository.dart';
import 'package:survey_flutter/api/storage/hive_storage.dart';
import 'package:survey_flutter/api/storage/shared_preference.dart';
import 'package:survey_flutter/usecases/login_use_case.dart';

import '../util/async_listener.dart';

@GenerateMocks([
  ApiService,
  DioError,
  AuthRepository,
  FlutterSecureStorage,
  SharedPreference,
  LoginUseCase,
  AsyncListener,
  SurveyRepository,
  HiveStorage,
])
main() {
  // empty class to generate mock repository classes
}

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:survey_flutter/api/api_service.dart';
import 'package:mockito/annotations.dart';
import 'package:survey_flutter/api/repository/auth_repository.dart';
import 'package:survey_flutter/api/repository/survey_repository.dart';
import 'package:survey_flutter/api/storage/hive_storage.dart';
import 'package:survey_flutter/api/storage/shared_preference.dart';
import 'package:survey_flutter/model/surveys_parameters.dart';
import 'package:survey_flutter/usecases/get_cached_surveys_use_case.dart';
import 'package:survey_flutter/usecases/get_surveys_use_case.dart';
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
  GetSurveysUseCase,
  GetCachedSurveysUseCase,
  SurveysParameters,
])
main() {
  // empty class to generate mock repository classes
}

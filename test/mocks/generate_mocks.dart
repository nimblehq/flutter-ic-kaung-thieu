import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:survey_flutter/api/api_service.dart';
import 'package:mockito/annotations.dart';
import 'package:survey_flutter/api/repository/login_repository.dart';
import 'package:survey_flutter/api/repository/shared_preference_repository.dart';

@GenerateMocks([
  ApiService,
  DioError,
  LoginRepository,
  FlutterSecureStorage,
  SharedPreferenceRepository
])
main() {
  // empty class to generate mock repository classes
}

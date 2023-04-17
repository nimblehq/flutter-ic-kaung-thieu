import 'package:dio/dio.dart';
import 'package:survey_flutter/api/api_service.dart';
import 'package:mockito/annotations.dart';
import 'package:survey_flutter/api/repository/login_repository.dart';

@GenerateMocks([
  ApiService,
  DioError,
  LoginRepository,
])
main() {
  // empty class to generate mock repository classes
}

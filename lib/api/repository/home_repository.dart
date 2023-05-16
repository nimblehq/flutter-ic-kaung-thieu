import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/api_service.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/api/storage/shared_preference.dart';
import 'package:survey_flutter/di/provider/dio_provider.dart';
import 'package:survey_flutter/model/response/survey_data_response.dart';

final surveyRepositoryProvider = Provider<SurveyRepository>((ref) {
  final sharedPreference = ref.watch(sharedPreferenceProvider);
  return SurveyRepositoryImpl(
    ApiService(DioProvider().getDioAuthorized(sharedPreference)),
  );
});

abstract class SurveyRepository {
  Future<SurveyDataResponse> getSurveys({
    required int pageNumber,
    required int pageSize,
  });
}

class SurveyRepositoryImpl extends SurveyRepository {
  final ApiService _apiService;

  SurveyRepositoryImpl(this._apiService);

  @override
  Future<SurveyDataResponse> getSurveys(
      {required int pageNumber, required int pageSize}) async {
    try {
      final result = await _apiService.getSurveys(pageNumber, pageSize);
      return result;
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}

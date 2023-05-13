import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/api_service.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/api/storage/shared_preference.dart';
import 'package:survey_flutter/di/provider/dio_provider.dart';
import 'package:survey_flutter/model/response/survey_data_response.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final sharedPreference = ref.watch(sharedPreferenceProvider);
  return HomeRepositoryImpl(
    ApiService(DioProvider().getDioAuthorized(sharedPreference)),
  );
});

abstract class HomeRepository {
  Future<SurveyDataResponse> getSurveys({
    required int pageNumber,
    required int pageSize,
  });
}

class HomeRepositoryImpl extends HomeRepository {
  final ApiService _apiService;

  HomeRepositoryImpl(this._apiService);

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
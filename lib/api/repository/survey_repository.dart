import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/api_service.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/api/storage/hive_storage.dart';
import 'package:survey_flutter/api/storage/shared_preference.dart';
import 'package:survey_flutter/di/provider/dio_provider.dart';
import 'package:survey_flutter/model/response/survey_data_response.dart';
import 'package:survey_flutter/usecases/refresh_token_use_case.dart';
import 'package:survey_flutter/utils/int_extension.dart';

final surveyRepositoryProvider = Provider<SurveyRepository>((ref) {
  final sharedPreference = ref.watch(sharedPreferenceProvider);
  final refreshTokenUseCase = ref.watch(refreshTokenUseCaseProvider);
  final hiveStorage = ref.watch(hiveStorageProvider);
  return SurveyRepositoryImpl(
    apiService: ApiService(DioProvider().getDioAuthorized(
      sharedPreference: sharedPreference,
      refreshTokenUseCase: refreshTokenUseCase,
    )),
    hiveStorage: hiveStorage,
  );
});

abstract class SurveyRepository {
  Future<void> getSurveys({
    required int pageNumber,
    required int pageSize,
  });
}

class SurveyRepositoryImpl extends SurveyRepository {
  final ApiService _apiService;
  final HiveStorage _hiveStorage;

  SurveyRepositoryImpl({
    required ApiService apiService,
    required HiveStorage hiveStorage,
  })  : _apiService = apiService,
        _hiveStorage = hiveStorage;

  @override
  Future<void> getSurveys(
      {required int pageNumber, required int pageSize}) async {
    try {
      final result = await _apiService.getSurveys(pageNumber, pageSize);
      if (result.surveys.isNotEmpty) {
        await _hiveStorage.saveSurveys(
          result.toSurveys(),
          pageNumber.isFirstPage(),
        );
      }
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}

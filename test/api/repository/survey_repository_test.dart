import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/api/repository/survey_repository.dart';
import 'package:survey_flutter/model/response/survey_detail_data_response.dart';
import 'package:survey_flutter/model/response/survey_detail_response.dart';

import '../../mocks/generate_mocks.mocks.dart';
import '../../mocks/mock_util.dart';

void main() {
  group('SurveyRepository', () {
    MockApiService mockApiService = MockApiService();
    MockHiveStorage mockHiveStorage = MockHiveStorage();

    late SurveyRepository repository;

    setUp(() => repository = SurveyRepositoryImpl(
          apiService: mockApiService,
          hiveStorage: mockHiveStorage,
        ));

    test('When calling getSurveys successfully, it emits surveys', () async {
      when(mockApiService.getSurveys(any, any))
          .thenAnswer((_) async => MockUtil.surveyDataResponse);

      await repository.getSurveys(pageNumber: 1, pageSize: 1);

      verify(mockHiveStorage.saveSurveys(any, any)).called(1);
    });

    test(
        'When calling getSurveys unsuccessfully, it throws NetworkExceptions error ',
        () async {
      when(mockApiService.getSurveys(any, any)).thenThrow(MockDioError());

      expect(() => repository.getSurveys(pageNumber: 1, pageSize: 1),
          throwsA(isA<NetworkExceptions>()));
    });

    test('When calling getSurveyDetail successfully, it emits a survey',
        () async {
      when(mockApiService.getSurveyDetail(any)).thenAnswer(
          (_) async => SurveyDetailDataResponse(SurveyDetailResponse()));

      await repository.getSurveyDetail('surveyId');

      verify(mockApiService.getSurveyDetail(any)).called(1);
    });

    test(
        'When calling getSurveyDetail unsuccessfully, it throws NetworkExceptions error ',
        () async {
      when(mockApiService.getSurveyDetail(any)).thenThrow(MockDioError());

      expect(() => repository.getSurveyDetail('surveyId'),
          throwsA(isA<NetworkExceptions>()));
    });

    test('When calling submitSurvey successfully, it emits a success',
        () async {
      when(mockApiService.submitSurveys(any)).thenAnswer((_) => Future.value());

      await repository.submitSurveys(MockUtil.submitSurveysRequest);

      verify(mockApiService.submitSurveys(any)).called(1);
    });

    test(
        'When calling submitSurvey unsuccessfully, it throws NetworkExceptions error ',
        () async {
      when(mockApiService.submitSurveys(any)).thenThrow(MockDioError());

      expect(() => repository.submitSurveys(MockUtil.submitSurveysRequest),
          throwsA(isA<NetworkExceptions>()));
    });
  });
}

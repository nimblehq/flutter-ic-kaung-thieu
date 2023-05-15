import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/api/repository/survey_repository.dart';

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
  });
}

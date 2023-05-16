import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/api/repository/home_repository.dart';

import '../../mocks/generate_mocks.mocks.dart';
import '../../mocks/mock_util.dart';

void main() {
  group('SurveyRepository', () {
    MockApiService mockApiService = MockApiService();

    late SurveyRepository repository;

    setUp(() => repository = SurveyRepositoryImpl(mockApiService));

    test('When calling getSurveys successfully, it emits surveys', () async {
      when(mockApiService.getSurveys(any, any))
          .thenAnswer((_) async => MockUtil.surveyDataResponse);

      final result = await repository.getSurveys(pageNumber: 1, pageSize: 1);

      expect(result.surveys.length, 1);
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

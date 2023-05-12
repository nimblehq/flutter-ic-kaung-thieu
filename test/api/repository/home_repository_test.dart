import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/api/repository/home_repository.dart';

import '../../mocks/generate_mocks.mocks.dart';
import '../../mocks/mock_util.dart';

void main() {
  group('HomeRepository', () {
    MockApiService mockApiService = MockApiService();

    late HomeRepository repository;

    setUp(() => repository = HomeRepositoryImpl(mockApiService));

    test('When get surveys successfully, it emits surveys', () async {
      when(mockApiService.getSurveys(any, any))
          .thenAnswer((_) async => MockUtil.surveyDataResponse);

      final result = await repository.getSurveys(pageNumber: 1, pageSize: 1);

      expect(result.surveys.length, 1);
    });

    test('When get surveys unsuccessfully, it throws NetworkExceptions error ',
        () async {
      when(mockApiService.getSurveys(any, any)).thenThrow(MockDioError());

      expect(() => repository.getSurveys(pageNumber: 1, pageSize: 1),
          throwsA(isA<NetworkExceptions>()));
    });
  });
}

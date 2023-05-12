import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/model/response/surveys_parameters.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/get_surveys_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';
import '../mocks/mock_util.dart';

void main() {
  group('GetSurveyUseCase', () {
    MockHomeRepository mockHomeRepository = MockHomeRepository();

    late GetSurveysUseCase getSurveysUseCase;

    setUp(() => getSurveysUseCase = GetSurveysUseCase(mockHomeRepository));

    test('When get surveys successfully, it emits success', () async {
      when(mockHomeRepository.getSurveys(
        pageNumber: anyNamed('pageNumber'),
        pageSize: anyNamed('pageSize'),
      )).thenAnswer((_) async => MockUtil.surveyDataResponse);

      final result = await getSurveysUseCase
          .call(const SurveysParameters(pageNumber: 1, pageSize: 1));
      expect(result is Success, true);
    });

    test('When get surveys unsuccessfully, it emits failed', () async {
      when(mockHomeRepository.getSurveys(
        pageNumber: anyNamed('pageNumber'),
        pageSize: anyNamed('pageSize'),
      )).thenThrow(MockDioError());

      final result = await getSurveysUseCase
          .call(const SurveysParameters(pageNumber: 1, pageSize: 1));
      expect(result is Failed, true);
    });
  });
}

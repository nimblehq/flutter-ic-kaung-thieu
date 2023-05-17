import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/model/response/survey_detail_data_response.dart';
import 'package:survey_flutter/model/response/survey_detail_response.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/get_survey_detail_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetSurveyDetailUseCase', () {
    MockSurveyRepository mockSurveyRepository = MockSurveyRepository();

    late GetSurveyDetailUseCase getSurveyDetailUseCase;

    setUp(() =>
        getSurveyDetailUseCase = GetSurveyDetailUseCase(mockSurveyRepository));

    test('When getSurveyDetail successfully, it emits success', () async {
      when(mockSurveyRepository.getSurveyDetail(any)).thenAnswer(
          (_) async => SurveyDetailDataResponse(SurveyDetailResponse()));

      final result = await getSurveyDetailUseCase.call('surveyId');
      expect(result, isA<Success<SurveyDetailDataResponse>>());
    });

    test('When getSurveyDetail unsuccessfully, it emits failed', () async {
      when(mockSurveyRepository.getSurveyDetail(any)).thenThrow(MockDioError());

      final result = await getSurveyDetailUseCase.call('surveyId');
      expect(result, isA<Failed>());
    });
  });
}

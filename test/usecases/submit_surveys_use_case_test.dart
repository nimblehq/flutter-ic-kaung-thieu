import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/submit_survey_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';
import '../mocks/mock_util.dart';

void main() {
  group('SubmitSurveyUseCase', () {
    MockSurveyRepository mockSurveyRepository = MockSurveyRepository();

    late SubmitSurveyUseCase submitSurveyUseCase;

    setUp(
        () => submitSurveyUseCase = SubmitSurveyUseCase(mockSurveyRepository));

    test(
        'When calling submitSurvey with SubmitSurveyRequest successfully, it emits success',
        () async {
      when(mockSurveyRepository.submitSurvey(any))
          .thenAnswer((_) => Future.value());

      final result =
          await submitSurveyUseCase.call(MockUtil.submitSurveyRequest);
      expect(result, isA<Success>());
    });

    test(
      'When calling submitSurvey with SubmitSurveyRequest unsuccessfully, it emits failed',
      () async {
        when(mockSurveyRepository.submitSurvey(any)).thenThrow(MockDioError());

        final result =
            await submitSurveyUseCase.call(MockUtil.submitSurveyRequest);
        expect(result, isA<Failed>());
      },
    );
  });
}

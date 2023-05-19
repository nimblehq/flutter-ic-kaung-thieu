import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/submit_surveys_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';
import '../mocks/mock_util.dart';

void main() {
  group('SubmitSurveysUseCase', () {
    MockSurveyRepository mockSurveyRepository = MockSurveyRepository();

    late SubmitSurveysUseCase submitSurveysUseCase;

    setUp(() =>
        submitSurveysUseCase = SubmitSurveysUseCase(mockSurveyRepository));

    test(
        'When calling submitSurveys with SubmitSurveysRequest successfully, it emits success',
        () async {
      when(mockSurveyRepository.submitSurveys(any))
          .thenAnswer((_) => Future.value());

      final result =
          await submitSurveysUseCase.call(MockUtil.submitSurveysRequest);
      expect(result, isA<Success>());
    });

    test(
      'When calling submitSurveys with SubmitSurveysRequest unsuccessfully, it emits failed',
      () async {
        when(mockSurveyRepository.submitSurveys(any)).thenThrow(MockDioError());

        final result =
            await submitSurveysUseCase.call(MockUtil.submitSurveysRequest);
        expect(result, isA<Failed>());
      },
    );
  });
}

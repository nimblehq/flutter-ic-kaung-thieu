import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/model/hives/survey.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/get_cached_surveys_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';
import '../mocks/mock_util.dart';

void main() {
  group('GetCachedSurveysUseCase', () {
    MockHiveStorage mockHiveStorage = MockHiveStorage();

    late GetCachedSurveysUseCase getCachedSurveyUseCase;

    setUp(() =>
        getCachedSurveyUseCase = GetCachedSurveysUseCase(mockHiveStorage));

    test('When get cached surveys, it emits success', () async {
      when(mockHiveStorage.getSurveys()).thenAnswer((_) async => [
            MockUtil.survey,
          ]);

      final result = await getCachedSurveyUseCase.call();
      expect(result is Success<List<Survey>>, true);
    });
  });
}

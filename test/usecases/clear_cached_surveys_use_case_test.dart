import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/usecases/clear_cached_surveys_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('ClearCachedSurveysUseCase', () {
    MockHiveStorage mockHiveStorage = MockHiveStorage();

    late ClearCachedSurveysUseCase clearCachedSurveysUseCase;

    setUp(() =>
        clearCachedSurveysUseCase = ClearCachedSurveysUseCase(mockHiveStorage));

    test('When call ClearCachedSurveysUseCase, it call clearSurveys', () async {
      when(mockHiveStorage.clearSurveys()).thenAnswer((_) async => 1);
      await clearCachedSurveysUseCase.call();

      verify(mockHiveStorage.clearSurveys()).called(1);
    });
  });
}

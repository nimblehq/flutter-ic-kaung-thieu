import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/get_profile_url_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';
import '../mocks/mock_util.dart';

void main() {
  group('GetProfileUrlUseCase', () {
    MockSurveyRepository mockSurveyRepository = MockSurveyRepository();

    late GetProfileUrlUseCase getProfileUrlUseCase;

    setUp(() =>
        getProfileUrlUseCase = GetProfileUrlUseCase(mockSurveyRepository));

    test('When calling profile successfully, it emits success', () async {
      when(mockSurveyRepository.getProfile())
          .thenAnswer((_) async => MockUtil.profileDataResponse);

      final result = await getProfileUrlUseCase.call();
      expect(result is Success, true);
    });

    test('When calling profile unsuccessfully, it emits failed', () async {
      when(mockSurveyRepository.getProfile()).thenThrow(MockDioError());

      final result = await getProfileUrlUseCase.call();
      expect(result is Failed, true);
    });
  });
}

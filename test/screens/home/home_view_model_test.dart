import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/model/survey_model.dart';
import 'package:survey_flutter/screens/home/home_view_model.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/get_cached_surveys_use_case.dart';
import 'package:survey_flutter/usecases/get_surveys_use_case.dart';

import '../../mocks/generate_mocks.mocks.dart';
import '../../mocks/mock_util.dart';

void main() {
  final MockGetCachedSurveysUseCase mockGetCachedSurveysUseCase =
      MockGetCachedSurveysUseCase();
  final MockGetSurveysUseCase mockGetSurveysUseCase = MockGetSurveysUseCase();

  late ProviderContainer container;

  setUp(() {
    final providerContainer = ProviderContainer(overrides: [
      getCachedSurveysUseCaseProvider
          .overrideWithValue(mockGetCachedSurveysUseCase),
      getSurveysUseCaseProvider.overrideWithValue(mockGetSurveysUseCase),
    ]);
    container = providerContainer;
  });

  tearDown(() => container.dispose());

  group('HomeViewModel', () {
    test('When in initial state, it emits shimmer correspondingly', () {
      when(mockGetSurveysUseCase.call(any))
          .thenAnswer((_) async => Success(MockUtil.surveyDataResponse));
      when(mockGetCachedSurveysUseCase.call())
          .thenAnswer((_) async => Success([MockUtil.survey]));

      final viewModel = container.read(homeViewModelProvider.notifier);
      expect(
        viewModel.shouldShowShimmer,
        emitsInOrder(
          [
            true,
            false,
          ],
        ),
      );
    });

    test(
        'When calling getSurveysUseCase successfully, it emits the corresponding surveys',
        () {
      when(mockGetSurveysUseCase.call(any))
          .thenAnswer((_) async => Success(MockUtil.surveyDataResponse));
      when(mockGetCachedSurveysUseCase.call())
          .thenAnswer((_) async => Success([MockUtil.survey]));

      final viewModel = container.read(homeViewModelProvider.notifier);
      expect(
        viewModel.surveys,
        emitsInOrder(
          [
            isA<List<SurveyModel>>(),
          ],
        ),
      );
    });

    test(
        'When calling getSurveysUseCase failed, it emits the corresponding error and surveys from cache',
        () {
      final exception =
          UseCaseException(const NetworkExceptions.unauthorisedRequest());
      when(mockGetSurveysUseCase.call(any))
          .thenAnswer((_) async => Failed(exception));
      when(mockGetCachedSurveysUseCase.call())
          .thenAnswer((_) async => Success([MockUtil.survey]));

      final viewModel = container.read(homeViewModelProvider.notifier);
      expect(
        viewModel.isError,
        emitsInOrder(
          [
            isA<String>(),
          ],
        ),
      );
      expect(
        viewModel.surveys,
        emitsInOrder(
          [
            isA<List<SurveyModel>>(),
          ],
        ),
      );
    });

    test(
        'When calling getSurveysUseCase failed, it calls getCachedSurveysUseCase',
        () async {
      final exception =
          UseCaseException(const NetworkExceptions.unauthorisedRequest());
      when(mockGetSurveysUseCase.call(any))
          .thenAnswer((_) async => Failed(exception));
      when(mockGetCachedSurveysUseCase.call())
          .thenAnswer((_) async => Success([MockUtil.survey]));

      final viewModel = container.read(homeViewModelProvider.notifier);
      await viewModel.getSurveyList();
      verifyInOrder([
        mockGetSurveysUseCase.call(any),
        mockGetCachedSurveysUseCase.call()
      ]);
    });

    test(
        'When calling getSurveysUseCase successfully, it does NOT call getCachedSurveysUseCase',
        () async {
      when(mockGetSurveysUseCase.call(any))
          .thenAnswer((_) async => Success(MockUtil.surveyDataResponse));
      when(mockGetCachedSurveysUseCase.call())
          .thenAnswer((_) async => Success([MockUtil.survey]));

      final viewModel = container.read(homeViewModelProvider.notifier);
      await viewModel.getSurveyList();
      verifyInOrder([
        mockGetSurveysUseCase.call(any),
      ]);
    });
  });
}

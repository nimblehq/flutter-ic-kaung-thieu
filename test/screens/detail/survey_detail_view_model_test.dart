import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/model/response/survey_detail_data_response.dart';
import 'package:survey_flutter/model/response/survey_detail_response.dart';
import 'package:survey_flutter/model/survey_detail_model.dart';
import 'package:survey_flutter/screens/detail/survey_detail_view_model.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/get_survey_detail_use_case.dart';
import 'package:survey_flutter/usecases/submit_survey_use_case.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  final MockGetSurveyDetailUseCase mockGetSurveyDetailUseCase =
      MockGetSurveyDetailUseCase();
  final MockSubmitSurveyUseCase mockSubmitSurveyUseCase =
      MockSubmitSurveyUseCase();

  late ProviderContainer container;

  setUp(() {
    final providerContainer = ProviderContainer(overrides: [
      getSurveyDetailUseCaseProvider
          .overrideWithValue(mockGetSurveyDetailUseCase),
      submitSurveyUseCaseProvider.overrideWithValue(mockSubmitSurveyUseCase),
    ]);
    container = providerContainer;
  });

  tearDown(() => container.dispose());

  group('SurveyDetailViewModel', () {
    test('When in initial state, surveyDetail does not emit anything', () {
      final viewModel = container.read(surveyDetailViewModelProvider.notifier);
      expect(viewModel.surveyDetail, emitsDone);
    });

    test('When calling getSurveyDetail successfully, it emits success', () {
      when(mockGetSurveyDetailUseCase.call(any)).thenAnswer((_) async =>
          Success(SurveyDetailDataResponse(SurveyDetailResponse())));

      final viewModel = container.read(surveyDetailViewModelProvider.notifier);
      viewModel.getSurveyDetail('123');
      expect(
        viewModel.surveyDetail,
        emitsInOrder([
          isA<SurveyDetailModel>(),
          emitsDone,
        ]),
      );
    });

    test('When calling getSurveyDetail unsuccessfully, it emits error', () {
      final exception =
          UseCaseException(const NetworkExceptions.unauthorisedRequest());
      when(mockGetSurveyDetailUseCase.call(any))
          .thenAnswer((_) async => Failed(exception));

      final viewModel = container.read(surveyDetailViewModelProvider.notifier);
      viewModel.getSurveyDetail('123');
      expect(
        viewModel.isError,
        emitsInOrder(
          [
            isA<String>(),
          ],
        ),
      );
    });

    test('When calling submitSurvey successfully, isSubmitSuccess emits true',
        () {
      when(mockSubmitSurveyUseCase.call(any))
          .thenAnswer((_) async => Success(null));

      final viewModel = container.read(surveyDetailViewModelProvider.notifier);
      viewModel.submitSurvey('123');
      expect(
        viewModel.isSubmitSuccess,
        emits(true),
      );
    });

    test(
        'When calling submitSurvey unsuccessfully, isSubmitSuccess emits false',
        () {
      final exception =
          UseCaseException(const NetworkExceptions.unauthorisedRequest());
      when(mockSubmitSurveyUseCase.call(any))
          .thenAnswer((_) async => Failed(exception));

      final viewModel = container.read(surveyDetailViewModelProvider.notifier);
      viewModel.submitSurvey('123');
      expect(
        viewModel.isSubmitSuccess,
        emits(false),
      );
    });
  });
}

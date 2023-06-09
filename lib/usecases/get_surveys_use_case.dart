import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/repository/survey_repository.dart';
import 'package:survey_flutter/model/response/survey_data_response.dart';
import 'package:survey_flutter/model/surveys_parameters.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final getSurveysUseCaseProvider =
    Provider((ref) => GetSurveysUseCase(ref.watch(surveyRepositoryProvider)));

class GetSurveysUseCase extends UseCase<void, SurveysParameters> {
  final SurveyRepository _surveyRepository;

  GetSurveysUseCase(this._surveyRepository);

  @override
  Future<Result<SurveyDataResponse>> call(SurveysParameters params) async {
    try {
      final result = await _surveyRepository.getSurveys(
        pageNumber: params.pageNumber,
        pageSize: params.pageSize,
      );
      return Success(result);
    } catch (e) {
      return Failed(UseCaseException(e));
    }
  }
}

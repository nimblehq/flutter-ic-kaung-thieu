import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/repository/home_repository.dart';
import 'package:survey_flutter/model/surveys_parameters.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final getSurveysUseCaseProvider =
    Provider((ref) => GetSurveysUseCase(ref.watch(surveyRepositoryProvider)));

class GetSurveysUseCase extends UseCase<void, SurveysParameters> {
  final SurveyRepository _homeRepository;

  GetSurveysUseCase(this._homeRepository);

  @override
  Future<Result<void>> call(SurveysParameters params) async {
    try {
      await _homeRepository.getSurveys(
        pageNumber: params.pageNumber,
        pageSize: params.pageSize,
      );
      return Success(null);
    } catch (e) {
      return Failed(UseCaseException(e));
    }
  }
}

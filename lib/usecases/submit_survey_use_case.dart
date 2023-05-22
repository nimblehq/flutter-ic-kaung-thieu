import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/repository/survey_repository.dart';
import 'package:survey_flutter/model/request/submit_survey_request.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final submitSurveyUseCaseProvider = Provider((ref) {
  return SubmitSurveyUseCase(ref.watch(surveyRepositoryProvider));
});

class SubmitSurveyUseCase extends UseCase<void, SubmitSurveyRequest> {
  final SurveyRepository _surveyRepository;

  SubmitSurveyUseCase(this._surveyRepository);

  @override
  Future<Result<void>> call(SubmitSurveyRequest params) async {
    try {
      final result = await _surveyRepository.submitSurvey(params);
      return Success(result);
    } catch (e) {
      return Failed(UseCaseException(e));
    }
  }
}

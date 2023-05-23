// ignore_for_file: avoid_renaming_method_parameters
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/repository/survey_repository.dart';
import 'package:survey_flutter/model/response/survey_detail_data_response.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final getSurveyDetailUseCaseProvider = Provider(
    (ref) => GetSurveyDetailUseCase(ref.watch(surveyRepositoryProvider)));

class GetSurveyDetailUseCase extends UseCase<SurveyDetailDataResponse, String> {
  final SurveyRepository _surveyRepository;

  GetSurveyDetailUseCase(this._surveyRepository);

  @override
  Future<Result<SurveyDetailDataResponse>> call(String surveyId) async {
    try {
      final result = await _surveyRepository.getSurveyDetail(surveyId);
      return Success(result);
    } catch (e) {
      return Failed(UseCaseException(e));
    }
  }
}

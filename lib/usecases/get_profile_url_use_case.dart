import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/repository/survey_repository.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final getProfileUrlUseCaseProvider = Provider(
  (ref) => GetProfileUrlUseCase(ref.watch(surveyRepositoryProvider)),
);

class GetProfileUrlUseCase extends NoParamsUseCase<String> {
  final SurveyRepository _surveyRepository;

  GetProfileUrlUseCase(this._surveyRepository);

  @override
  Future<Result<String>> call() async {
    try {
      final profile = await _surveyRepository.getProfile();
      return Success(profile.profileResponse?.avatarUrl ?? '');
    } catch (e) {
      return Failed(UseCaseException(e));
    }
  }
}

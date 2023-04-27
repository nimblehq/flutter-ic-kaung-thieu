import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/repository/shared_preference_repository.dart';
import 'package:survey_flutter/model/authentication_parameters.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final getAuthenticationUseCaseProvider = Provider((ref) {
  return GetAuthenticationUseCase(
    ref.watch(sharedPreferenceRepositoryProvider),
  );
});

class GetAuthenticationUseCase extends UseCase<AuthenticationParameters, void> {
  final SharedPreferenceRepository _sharedPreferenceRepository;

  GetAuthenticationUseCase(this._sharedPreferenceRepository);

  @override
  Future<Result<AuthenticationParameters>> call(void params) async {
    try {
      final result = await _sharedPreferenceRepository.getSavedAuthentication();
      return Success(result);
    } catch (e) {
      return Failed(UseCaseException(e));
    }
  }
}

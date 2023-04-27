import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/repository/shared_preference_repository.dart';
import 'package:survey_flutter/model/authentication_parameters.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final saveAuthenticationUseCaseProvider = Provider((ref) {
  return SaveAuthenticationUseCase(
    ref.watch(sharedPreferenceRepositoryProvider),
  );
});

class SaveAuthenticationUseCase
    extends UseCase<void, AuthenticationParameters> {
  final SharedPreferenceRepository _sharedPreferenceRepository;

  SaveAuthenticationUseCase(this._sharedPreferenceRepository);

  @override
  Future<Result<void>> call(AuthenticationParameters params) async {
    try {
      await _sharedPreferenceRepository.saveAuthentication(
          authenticationModel: params);
      return Success(null);
    } catch (e) {
      return Failed(UseCaseException(e));
    }
  }
}

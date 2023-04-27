import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/repository/shared_preference_repository.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final saveAccessTokenUseCaseProvider = Provider((ref) {
  return SaveAccessTokenUseCase(
    ref.watch(sharedPreferenceRepositoryProvider),
  );
});

class SaveAccessTokenUseCase extends UseCase<void, String> {
  final SharedPreferenceRepository _sharedPreferenceRepository;

  SaveAccessTokenUseCase(this._sharedPreferenceRepository);

  @override
  Future<Result<void>> call(String params) async {
    try {
      final result = await _sharedPreferenceRepository.saveAccessToken(params);
      return Success(result);
    } catch (e) {
      return Failed(UseCaseException(e));
    }
  }
}

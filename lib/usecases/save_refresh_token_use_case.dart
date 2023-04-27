import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/repository/shared_preference_repository.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final saveRefreshTokenUseCaseProvider = Provider((ref) {
  return SaveRefreshTokenUseCase(
    ref.watch(sharedPreferenceRepositoryProvider),
  );
});

class SaveRefreshTokenUseCase extends UseCase<void, String> {
  final SharedPreferenceRepository _sharedPreferenceRepository;

  SaveRefreshTokenUseCase(this._sharedPreferenceRepository);

  @override
  Future<Result<void>> call(String params) async {
    try {
      final result = await _sharedPreferenceRepository.saveRefreshToken(params);
      return Success(result);
    } catch (e) {
      return Failed(UseCaseException(e));
    }
  }
}

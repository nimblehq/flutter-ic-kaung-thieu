import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/repository/shared_preference_repository.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final getRefreshTokenUseCaseProvider = Provider((ref) {
  return GetRefreshTokenUseCase(
    ref.watch(sharedPreferenceRepositoryProvider),
  );
});

class GetRefreshTokenUseCase extends UseCase<String?, void> {
  final SharedPreferenceRepository _sharedPreferenceRepository;

  GetRefreshTokenUseCase(this._sharedPreferenceRepository);

  @override
  Future<Result<String?>> call(void params) async {
    try {
      final result = await _sharedPreferenceRepository.getRefreshToken();
      return Success(result);
    } catch (e) {
      return Failed(UseCaseException(e));
    }
  }
}

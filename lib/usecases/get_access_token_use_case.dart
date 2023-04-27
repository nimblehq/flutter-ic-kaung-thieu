import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/repository/shared_preference_repository.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final getAccessTokenUseCaseProvider = Provider((ref) {
  return GetAccessTokenUseCase(
    ref.watch(sharedPreferenceRepositoryProvider),
  );
});

class GetAccessTokenUseCase extends UseCase<String?, void> {
  final SharedPreferenceRepository _sharedPreferenceRepository;

  GetAccessTokenUseCase(this._sharedPreferenceRepository);

  @override
  Future<Result<String?>> call(void params) async {
    try {
      final result = await _sharedPreferenceRepository.getAccessToken();
      return Success(result);
    } catch (e) {
      return Failed(UseCaseException(e));
    }
  }
}

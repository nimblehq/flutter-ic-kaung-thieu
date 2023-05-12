import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/repository/auth_repository.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final refreshTokenUseCaseProvider = Provider((ref) {
  return RefreshTokenUseCase(ref.watch(authRepositoryProvider));
});

class RefreshTokenUseCase extends NoParamsUseCase<void> {
  final AuthRepository _authRepository;

  RefreshTokenUseCase(this._authRepository);

  @override
  Future<Result<void>> call() async {
    try {
      await _authRepository.refreshToken();
      return Success(null);
    } catch (e) {
      return Failed(UseCaseException(e));
    }
  }
}

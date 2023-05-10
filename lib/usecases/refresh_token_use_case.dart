import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/repository/login_repository.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final refreshTokenUseCaseProvider = Provider((ref) {
  return RefreshTokenUseCase(ref.watch(loginRepositoryProvider));
});

class RefreshTokenUseCase extends NoParamsUseCase<void> {
  final LoginRepository _loginRepository;

  RefreshTokenUseCase(this._loginRepository);

  @override
  Future<Result<void>> call() async {
    try {
      await _loginRepository.refreshToken();
      return Success(null);
    } catch (e) {
      return Failed(UseCaseException(e));
    }
  }
}

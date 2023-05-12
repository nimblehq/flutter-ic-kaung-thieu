import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/repository/auth_repository.dart';
import 'package:survey_flutter/model/login_parameters.dart';
import 'package:survey_flutter/model/response/login_data_response.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});

class LoginUseCase extends UseCase<LoginDataResponse, LoginParameters> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Future<Result<LoginDataResponse>> call(LoginParameters params) async {
    try {
      final result = await _authRepository.login(
        email: params.email,
        password: params.password,
      );
      return Success(result);
    } catch (e) {
      return Failed(UseCaseException(e));
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/repository/login_repository.dart';
import 'package:survey_flutter/model/login_parameters.dart';
import 'package:survey_flutter/model/response/login_response.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(loginRepositoryProvider));
});

class LoginUseCase extends UseCase<LoginResponse, LoginParameters> {
  final LoginRepository _loginRepository;

  LoginUseCase(this._loginRepository);

  @override
  Future<Result<LoginResponse>> call(LoginParameters params) async {
    try {
      final result = await _loginRepository.login(
        email: params.email,
        password: params.password,
      );
      return Success(result);
    } catch (e) {
      return Failed(UseCaseException(e));
    }
  }
}

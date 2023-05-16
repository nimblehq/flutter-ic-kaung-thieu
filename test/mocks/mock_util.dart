import 'package:survey_flutter/model/request/login_request.dart';
import 'package:survey_flutter/model/response/login_data_response.dart';
import 'package:survey_flutter/model/response/login_response.dart';

class MockUtil {
  static LoginRequest loginRequest = LoginRequest(
      grantType: 'password',
      email: 'test@gmail.com',
      password: 'password',
      clientId: 'clientId',
      clientSecret: 'clientSecret');

  static LoginDataResponse loginDataResponse = LoginDataResponse(loginResponse);

  static LoginResponse loginResponse = LoginResponse(
    id: '1',
    type: 'token',
    accessToken: 'accessToken',
    tokenType: 'tokenType',
    expiresIn: 1,
    createdAt: 1,
    refreshToken: 'refreshToken',
  );
}

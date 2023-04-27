import 'package:survey_flutter/model/authentication_parameters.dart';
import 'package:survey_flutter/model/request/login_request.dart';
import 'package:survey_flutter/model/response/login_attributes_response.dart';
import 'package:survey_flutter/model/response/login_response.dart';

class MockUtil {
  static LoginRequest loginRequest = LoginRequest(
      grantType: 'password',
      email: 'test@gmail.com',
      password: 'password',
      clientId: 'clientId',
      clientSecret: 'clientSecret');

  static LoginAttributeResponse loginAttributeResponse = LoginAttributeResponse(
      accessToken: 'accessToken',
      tokenType: 'tokenType',
      expiresIn: 1,
      createdAt: 1,
      refreshToken: 'refreshToken');

  static LoginResponse loginResponse = LoginResponse(
      id: 1, type: 'token', loginAttributeResponse: loginAttributeResponse);

  static AuthenticationParameters authenticationParameters =
      AuthenticationParameters(
          accessToken: 'accessToken',
          tokenType: 'tokenType',
          refreshToken: 'refreshToken');
}

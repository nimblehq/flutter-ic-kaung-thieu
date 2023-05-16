import 'package:survey_flutter/model/request/login_request.dart';
import 'package:survey_flutter/model/response/login_data_response.dart';
import 'package:survey_flutter/model/response/login_response.dart';
import 'package:survey_flutter/model/response/survey_data_response.dart';
import 'package:survey_flutter/model/response/survey_response.dart';

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

  static SurveyDataResponse surveyDataResponse =
      SurveyDataResponse([surveyResponse]);

  static SurveyResponse surveyResponse = SurveyResponse(
    id: '1',
    type: 'survey',
    description: 'description',
    thankEmailAboveThreshold: 'thankEmailAboveThreshold',
    thankEmailBelowThreshold: 'thankEmailBelowThreshold',
    isActive: false,
    coverImageUrl: 'coverImageUrl',
    createdAt: '',
    activeAt: '',
    inactiveAt: '',
    surveyType: 'surveyType',
  );
}

import 'package:dio/dio.dart';
import 'package:survey_flutter/model/request/login_request.dart';
import 'package:survey_flutter/model/request/auth_request.dart';
import 'package:survey_flutter/model/response/login_response.dart';
import 'package:survey_flutter/model/response/user_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // TODO add API endpoint
  @GET('users')
  Future<List<UserResponse>> getUsers();

  @POST('api/v1/oauth/token')
  Future<LoginResponse> logIn(@Body() LoginRequest loginRequest);

  @POST('api/v1/oauth/token')
  Future<LoginResponse> refreshToken(@Body() AuthRequest tokenRequest);
}

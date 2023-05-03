import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter/model/response/login_response.dart';

part 'login_data_response.g.dart';

@JsonSerializable()
class LoginDataResponse {
  @JsonKey(name: 'data')
  final LoginResponse? loginResponse;

  LoginDataResponse(this.loginResponse);

  factory LoginDataResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataResponseToJson(this);
}

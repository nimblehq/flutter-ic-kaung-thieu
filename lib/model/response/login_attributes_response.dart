import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_attributes_response.g.dart';

@JsonSerializable()
class LoginAttributeResponse {
  @JsonKey(name: 'access_token')
  final String? accessToken;
  @JsonKey(name: 'token_type')
  final String? tokenType;
  @JsonKey(name: 'expires_in')
  final int? expiresIn;
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;
  @JsonKey(name: 'created_at')
  final int? createdAt;

  LoginAttributeResponse(this.accessToken, this.tokenType, this.expiresIn,
      this.refreshToken, this.createdAt);

  factory LoginAttributeResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginAttributeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginAttributeResponseToJson(this);
}

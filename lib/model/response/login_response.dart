import 'package:json_annotation/json_annotation.dart';

import 'login_attributes_response.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'attributes')
  final LoginAttributeResponse? loginAttributeResponse;

  LoginResponse({
    this.id,
    this.type,
    this.loginAttributeResponse,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

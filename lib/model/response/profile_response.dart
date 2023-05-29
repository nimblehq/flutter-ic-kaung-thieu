import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  ProfileResponse({
    this.id,
    this.type,
    this.email,
    this.name,
    this.avatarUrl,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}

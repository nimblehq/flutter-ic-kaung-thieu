import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter/api/helpers/japx_helper.dart';
import 'package:survey_flutter/model/response/profile_response.dart';

part 'profile_data_response.g.dart';

@JsonSerializable()
class ProfileDataResponse {
  @JsonKey(name: 'data')
  final ProfileResponse? profileResponse;

  ProfileDataResponse(this.profileResponse);

  factory ProfileDataResponse.fromJson(Map<String, dynamic> json) {
    final decodedJson = decodeJson(json);
    return _$ProfileDataResponseFromJson(decodedJson);
  }
}

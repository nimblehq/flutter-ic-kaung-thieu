import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter/api/error/error_response.dart';

part 'error_list_response.g.dart';

@JsonSerializable()
class ErrorListResponse {
  @JsonKey(name: 'errors')
  final List<ErrorResponse> errors;

  ErrorListResponse({
    required this.errors,
  });

  factory ErrorListResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorListResponseToJson(this);
}

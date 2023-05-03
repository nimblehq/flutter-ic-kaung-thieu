import 'package:survey_flutter/api/error/error_response.dart';

class ErrorListResponse {
  final List<ErrorResponse> errors;

  ErrorListResponse({
    required this.errors,
  });

  factory ErrorListResponse.fromJson(Map<String, dynamic> json) {
    return ErrorListResponse(
      errors: (json['errors'] as List<dynamic>)
          .map((itemJson) =>
              ErrorResponse.fromJson(itemJson as Map<String, dynamic>))
          .toList(),
    );
  }
}

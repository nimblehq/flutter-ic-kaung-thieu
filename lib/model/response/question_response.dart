import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_response.g.dart';

@JsonSerializable()
class QuestionResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'type')
  final String? type;

  QuestionResponse({
    this.id,
    this.type,
  });

  factory QuestionResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionResponseToJson(this);
}

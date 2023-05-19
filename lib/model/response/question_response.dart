import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter/model/response/answer_response.dart';

part 'question_response.g.dart';

@JsonSerializable()
class QuestionResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'text')
  final String? text;
  @JsonKey(name: 'help_text')
  final String? helpText;
  @JsonKey(name: 'display_order')
  final int? displayOrder;
  @JsonKey(name: 'short_text')
  final String? shortText;
  @JsonKey(name: 'pick')
  final String? pick;
  @JsonKey(name: 'display_type')
  final String? displayType;
  @JsonKey(name: 'is_mandatory')
  final bool? isMandatory;
  @JsonKey(name: 'correct_answer_id')
  final String? correctAnswerId;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'cover_image_url')
  final String? coverImageUrl;
  @JsonKey(name: 'cover_image_opacity')
  final double? coverImageOpacity;
  @JsonKey(name: 'answers')
  final List<AnswerResponse>? answers;

  QuestionResponse({
    this.shortText,
    this.isMandatory,
    this.helpText,
    this.displayType,
    this.displayOrder,
    this.text,
    this.type,
    this.id,
    this.coverImageUrl,
    this.correctAnswerId,
    this.coverImageOpacity,
    this.imageUrl,
    this.pick,
    this.answers,
  });

  factory QuestionResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionResponseToJson(this);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer_response.g.dart';

@JsonSerializable()
class AnswerResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'text')
  final String? text;
  @JsonKey(name: 'help_text')
  final String? helpText;
  @JsonKey(name: 'input_mask_placeholder')
  final String? inputMaskPlaceholder;
  @JsonKey(name: 'short_text')
  final String? shortText;
  @JsonKey(name: 'is_mandatory')
  final bool? isMandatory;
  @JsonKey(name: 'is_customer_first_name')
  final bool? isCustomerFirstName;
  @JsonKey(name: 'is_customer_last_name')
  final bool? isCustomerLastName;
  @JsonKey(name: 'is_customer_title')
  final bool? isCustomerTitle;
  @JsonKey(name: 'is_customer_email')
  final bool? isCustomerEmail;
  @JsonKey(name: 'display_order')
  final int? displayOrder;
  @JsonKey(name: 'display_type')
  final String? displayType;
  @JsonKey(name: 'input_mask')
  final String? inputMask;
  @JsonKey(name: 'date_constraint')
  final String? dateConstraint;
  @JsonKey(name: 'default_value')
  final String? defaultValue;
  @JsonKey(name: 'response_class')
  final String? responseClass;
  @JsonKey(name: 'reference_identifier')
  final String? referenceIdentifier;
  @JsonKey(name: 'score')
  final int? score;

  AnswerResponse(
      {this.id,
      this.type,
      this.text,
      this.dateConstraint,
      this.defaultValue,
      this.displayOrder,
      this.displayType,
      this.helpText,
      this.inputMask,
      this.inputMaskPlaceholder,
      this.isCustomerEmail,
      this.isCustomerFirstName,
      this.isCustomerLastName,
      this.isCustomerTitle,
      this.isMandatory,
      this.referenceIdentifier,
      this.responseClass,
      this.score,
      this.shortText});

  factory AnswerResponse.fromJson(Map<String, dynamic> json) =>
      _$AnswerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerResponseToJson(this);
}

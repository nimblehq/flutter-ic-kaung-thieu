import 'package:freezed_annotation/freezed_annotation.dart';

part 'meta_response.g.dart';

@JsonSerializable()
class MetaResponse {
  @JsonKey(name: 'pages')
  final int pages;

  MetaResponse(this.pages);

  factory MetaResponse.fromJson(Map<String, dynamic> json) =>
      _$MetaResponseFromJson(json);
}

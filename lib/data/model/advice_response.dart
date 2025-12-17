import 'package:json_annotation/json_annotation.dart';

part 'advice_response.g.dart';

@JsonSerializable()
class AdviceResponse {
  @JsonKey(name: 'string_value')
  final String advice;

  const AdviceResponse({
    required this.advice,
  });

  factory AdviceResponse.fromJson(Map<String, dynamic> json) => _$AdviceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AdviceResponseToJson(this);
}
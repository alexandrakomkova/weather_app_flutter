import 'package:json_annotation/json_annotation.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  final double temperature;
  @JsonKey(name: 'weathercode')
  final double weatherCode;

  const WeatherResponse({
    required this.temperature,
    required this.weatherCode,
});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) => _$WeatherResponseFromJson(json);
}
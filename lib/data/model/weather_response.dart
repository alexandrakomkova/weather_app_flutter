import 'package:json_annotation/json_annotation.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  final double temperature;
  @JsonKey(name: 'weathercode')
  final double weatherConditionCode;
  @JsonKey(name: 'windspeed')
  final double windSpeed;
  @JsonKey(name: 'winddirection')
  final int windDirectionAngle;

  const WeatherResponse({
    required this.temperature,
    required this.windSpeed,
    required this.windDirectionAngle,
    required this.weatherConditionCode,
});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) => _$WeatherResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}
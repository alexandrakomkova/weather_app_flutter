import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/domain/model/weather_condition.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather extends Equatable {
  final double latitude;
  final double longitude;
  final double temperature;
  final double windSpeed;
  final String windDirection;
  final WeatherCondition weatherCondition;

  const Weather({
    required this.latitude,
    required this.longitude,
    required this.temperature,
    required this.windSpeed,
    required this.windDirection,
    required this.weatherCondition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  @override
  List<Object> get props => [
    longitude,
    latitude,
    temperature,
    windSpeed,
    windDirection,
    weatherCondition,
  ];

}
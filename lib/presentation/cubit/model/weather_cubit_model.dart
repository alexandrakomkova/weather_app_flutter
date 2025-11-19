import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/domain/model/weather.dart';

import '/domain/model/weather_condition.dart';

part 'weather_cubit_model.g.dart';

enum TemperatureUnits { fahrenheit, celsius }

extension TemperatureUnitsX on TemperatureUnits {
  bool get isFahrenheit => this == TemperatureUnits.fahrenheit;
  bool get isCelsius => this == TemperatureUnits.celsius;
}

@JsonSerializable()
class Temperature extends Equatable {
  const Temperature({required this.value});

  factory Temperature.fromJson(Map<String, dynamic> json) =>
      _$TemperatureFromJson(json);

  final double value;

  Map<String, dynamic> toJson() => _$TemperatureToJson(this);

  @override
  List<Object> get props => [value];
}

@JsonSerializable()
class WeatherCubitModel extends Equatable{
  final WeatherCondition weatherCondition;
  final DateTime lastUpdated;
  final double latitude;
  final double longitude;
  final String windDirection;
  final double windSpeed;
  final Temperature temperature;

  const WeatherCubitModel({
    required this.weatherCondition,
    required this.lastUpdated,
    required this.latitude,
    required this.longitude,
    required this.windSpeed,
    required this.windDirection,
    required this.temperature,
  });

  factory WeatherCubitModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherCubitModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherCubitModelToJson(this);

  factory WeatherCubitModel.fromRepository(Weather weather) {
    return WeatherCubitModel(
      weatherCondition: weather.weatherCondition,
      lastUpdated: DateTime.now(),
      latitude: weather.latitude,
      longitude: weather.longitude,
      temperature: Temperature(value: weather.temperature),
      windDirection: weather.windDirection,
      windSpeed:  weather.windSpeed,
    );
  }

  static final empty = WeatherCubitModel(
    weatherCondition: WeatherCondition.unknown,
    lastUpdated: DateTime(0),
    temperature: const Temperature(value: 0),
    windDirection: '',
    windSpeed: 0.0,
    longitude: 0.0,
    latitude: 0.0,
  );

  WeatherCubitModel copyWith({
    WeatherCondition? condition,
    DateTime? lastUpdated,
    double? latitude,
    double? longitude,
    Temperature? temperature,
    int? isDay,
    double? windSpeed,
    String? windDirection,
  }) {
    return WeatherCubitModel(
        weatherCondition: condition ?? this.weatherCondition,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        temperature: temperature ?? this.temperature,
        windSpeed: windSpeed ?? this.windSpeed,
        windDirection: windDirection ?? this.windDirection,
    );
  }

  @override
  List<Object> get props => [
    weatherCondition,
    lastUpdated,
    latitude,
    longitude,
    temperature,
    windSpeed,
    windDirection,
  ];
}
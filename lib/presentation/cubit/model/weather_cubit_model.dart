import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/domain/model/weather_repository_model.dart';

import '../../../domain/model/weather_condition.dart';

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
  final WeatherCondition condition;
  final DateTime lastUpdated;
  final double latitude;
  final double longitude;
  final Temperature temperature;

  const WeatherCubitModel({
    required this.condition,
    required this.lastUpdated,
    required this.latitude,
    required this.longitude,
    required this.temperature,
  });

  factory WeatherCubitModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherCubitModelFromJson(json);

  factory WeatherCubitModel.fromRepository(WeatherRepositoryModel weather) {
    return WeatherCubitModel(
      condition: weather.weatherCondition,
      lastUpdated: DateTime.now(),
      latitude: weather.latitude,
      longitude: weather.longitude,
      temperature: Temperature(value: weather.temperature),
    );
  }

  static final empty = WeatherCubitModel(
    condition: WeatherCondition.unknown,
    lastUpdated: DateTime(0),
    temperature: const Temperature(value: 0),
    longitude: 0.0,
    latitude: 0.0,
  );

  WeatherCubitModel copyWith({
    WeatherCondition? condition,
    DateTime? lastUpdated,
    double? latitude,
    double? longitude,
    Temperature? temperature,
  }) {
    return WeatherCubitModel(
        condition: condition ?? this.condition,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        temperature: temperature ?? this.temperature,
    );
  }

  @override
  List<Object> get props => [condition, lastUpdated, latitude, longitude, temperature];
}
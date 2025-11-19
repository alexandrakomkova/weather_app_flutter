// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_cubit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Temperature _$TemperatureFromJson(Map<String, dynamic> json) =>
    Temperature(value: (json['value'] as num).toDouble());

Map<String, dynamic> _$TemperatureToJson(Temperature instance) =>
    <String, dynamic>{'value': instance.value};

WeatherCubitModel _$WeatherCubitModelFromJson(Map<String, dynamic> json) =>
    WeatherCubitModel(
      condition: $enumDecode(_$WeatherConditionEnumMap, json['condition']),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      windSpeed: (json['windSpeed'] as num).toDouble(),
      windDirection: json['windDirection'] as String,
      temperature: Temperature.fromJson(
        json['temperature'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$WeatherCubitModelToJson(WeatherCubitModel instance) =>
    <String, dynamic>{
      'condition': _$WeatherConditionEnumMap[instance.condition]!,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'windDirection': instance.windDirection,
      'windSpeed': instance.windSpeed,
      'temperature': instance.temperature,
    };

const _$WeatherConditionEnumMap = {
  WeatherCondition.clear: 'clear',
  WeatherCondition.mainlyClear: 'mainlyClear',
  WeatherCondition.rainy: 'rainy',
  WeatherCondition.rainShowers: 'rainShowers',
  WeatherCondition.cloudy: 'cloudy',
  WeatherCondition.thunderstorm: 'thunderstorm',
  WeatherCondition.drizzle: 'drizzle',
  WeatherCondition.freezingDrizzle: 'freezingDrizzle',
  WeatherCondition.snowy: 'snowy',
  WeatherCondition.unknown: 'unknown',
};

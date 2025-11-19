// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  temperature: (json['temperature'] as num).toDouble(),
  windSpeed: (json['windSpeed'] as num).toDouble(),
  windDirection: json['windDirection'] as String,
  weatherCondition: $enumDecode(
    _$WeatherConditionEnumMap,
    json['weatherCondition'],
  ),
);

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'temperature': instance.temperature,
  'windSpeed': instance.windSpeed,
  'windDirection': instance.windDirection,
  'weatherCondition': _$WeatherConditionEnumMap[instance.weatherCondition]!,
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

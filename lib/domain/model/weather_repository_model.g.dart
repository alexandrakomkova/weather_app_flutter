// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_repository_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherRepositoryModel _$WeatherRepositoryModelFromJson(
  Map<String, dynamic> json,
) => WeatherRepositoryModel(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  temperature: (json['temperature'] as num).toDouble(),
  weatherCondition: $enumDecode(
    _$WeatherConditionEnumMap,
    json['weatherCondition'],
  ),
);

Map<String, dynamic> _$WeatherRepositoryModelToJson(
  WeatherRepositoryModel instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'temperature': instance.temperature,
  'weatherCondition': _$WeatherConditionEnumMap[instance.weatherCondition]!,
};

const _$WeatherConditionEnumMap = {
  WeatherCondition.clear: 'clear',
  WeatherCondition.rainy: 'rainy',
  WeatherCondition.cloudy: 'cloudy',
  WeatherCondition.snowy: 'snowy',
  WeatherCondition.unknown: 'unknown',
};

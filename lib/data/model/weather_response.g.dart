// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) =>
    WeatherResponse(
      temperature: (json['temperature'] as num).toDouble(),
      weatherCode: (json['weathercode'] as num).toDouble(),
    );

Map<String, dynamic> _$WeatherResponseToJson(WeatherResponse instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'weathercode': instance.weatherCode,
    };

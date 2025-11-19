// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) =>
    WeatherResponse(
      temperature: (json['temperature'] as num).toDouble(),
      windSpeed: (json['windspeed'] as num).toDouble(),
      windDirection: (json['winddirection'] as num).toInt(),
      weatherCode: (json['weathercode'] as num).toDouble(),
    );

Map<String, dynamic> _$WeatherResponseToJson(WeatherResponse instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'weathercode': instance.weatherCode,
      'windspeed': instance.windSpeed,
      'winddirection': instance.windDirection,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherState _$WeatherStateFromJson(Map<String, dynamic> json) => WeatherState(
  status:
      $enumDecodeNullable(_$WeatherStatusEnumMap, json['status']) ??
      WeatherStatus.initial,
  temperatureUnits:
      $enumDecodeNullable(
        _$TemperatureUnitsEnumMap,
        json['temperatureUnits'],
      ) ??
      TemperatureUnits.celsius,
  weatherCubitModel: json['weatherCubitModel'] == null
      ? null
      : WeatherCubitModel.fromJson(
          json['weatherCubitModel'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$WeatherStateToJson(WeatherState instance) =>
    <String, dynamic>{
      'weatherCubitModel': instance.weatherCubitModel,
      'status': _$WeatherStatusEnumMap[instance.status]!,
      'temperatureUnits': _$TemperatureUnitsEnumMap[instance.temperatureUnits]!,
    };

const _$WeatherStatusEnumMap = {
  WeatherStatus.initial: 'initial',
  WeatherStatus.loading: 'loading',
  WeatherStatus.success: 'success',
  WeatherStatus.failure: 'failure',
};

const _$TemperatureUnitsEnumMap = {
  TemperatureUnits.fahrenheit: 'fahrenheit',
  TemperatureUnits.celsius: 'celsius',
};

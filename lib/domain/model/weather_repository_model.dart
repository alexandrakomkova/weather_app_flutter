import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/domain/model/weather_condition.dart';

part 'weather_repository_model.g.dart';

@JsonSerializable()
class WeatherRepositoryModel extends Equatable {
  final double latitude;
  final double longitude;
  final double temperature;
  final WeatherCondition weatherCondition;

  const WeatherRepositoryModel({
    required this.latitude,
    required this.longitude,
    required this.temperature,
    required this.weatherCondition,
  });

  factory WeatherRepositoryModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherRepositoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherRepositoryModelToJson(this);

  @override
  List<Object?> get props => [longitude, latitude, temperature, weatherCondition];

}
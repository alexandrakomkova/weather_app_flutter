part of 'weather_cubit.dart';

enum WeatherStatus { initial, loading, success, failure }

@JsonSerializable()
final class WeatherState extends Equatable {
  final WeatherCubitModel weatherCubitModel;
  final WeatherStatus status;
  final TemperatureUnits temperatureUnits;
  final String errorMessage;

  WeatherState({
    this.status = WeatherStatus.initial,
    this.temperatureUnits = TemperatureUnits.celsius,
    WeatherCubitModel? weatherCubitModel,
    this.errorMessage = '',
  }) : weatherCubitModel = weatherCubitModel ?? WeatherCubitModel.empty();

  WeatherState copyWith({
    WeatherStatus? status,
    TemperatureUnits? temperatureUnits,
    WeatherCubitModel? weatherCubitModel,
    String? errorMessage,
  }) {
    return WeatherState(
      status: status ?? this.status,
      temperatureUnits: temperatureUnits ?? this.temperatureUnits,
      weatherCubitModel: weatherCubitModel ?? this.weatherCubitModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory WeatherState.fromJson(Map<String, dynamic> json) =>
      _$WeatherStateFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherStateToJson(this);

  @override
  List<Object?> get props => [status, temperatureUnits, weatherCubitModel];
}

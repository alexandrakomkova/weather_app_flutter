part of 'weather_cubit.dart';

enum WeatherStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == WeatherStatus.loading;
  bool get isInitial => this == WeatherStatus.initial;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isFailure => this == WeatherStatus.failure;
}

@JsonSerializable()
final class WeatherState extends Equatable{
  final WeatherCubitModel weatherCubitModel;
  final WeatherStatus status;
  final TemperatureUnits temperatureUnits;

  WeatherState({
    this.status = WeatherStatus.initial,
    this.temperatureUnits = TemperatureUnits.celsius,
    WeatherCubitModel? weatherCubitModel,
  }): weatherCubitModel = weatherCubitModel ?? WeatherCubitModel.empty;

  WeatherState copyWith({
    WeatherStatus? status,
    TemperatureUnits? temperatureUnits,
    WeatherCubitModel? weatherCubitModel,
  }) {
    return WeatherState(
      status: status ?? this.status,
      temperatureUnits: temperatureUnits ?? this.temperatureUnits,
      weatherCubitModel: weatherCubitModel ?? this.weatherCubitModel,
    );
  }

  factory WeatherState.fromJson(Map<String, dynamic> json) =>
      _$WeatherStateFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherStateToJson(this);

  @override
  List<Object?> get props => [
    status,
    temperatureUnits,
    weatherCubitModel,
  ];
}

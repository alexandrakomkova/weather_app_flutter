import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/domain/repository/weather_repository.dart';
import 'package:weather_app/presentation/cubit/model/weather_cubit_model.dart';

part 'weather_cubit.g.dart';
part 'weather_state.dart';

class WeatherCubit extends HydratedCubit<WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherCubit(this._weatherRepository) : super(WeatherState());

  Future<void> fetchWeather({
    required double latitude,
    required double longitude,
  }) async {
    return await _getWeather(latitude: latitude, longitude: longitude);
  }

  Future<void> refreshWeather() async {
    if (state.status != WeatherStatus.success) return;

    if (state.weatherCubitModel == WeatherCubitModel.empty) return;

    _getWeather(
      latitude: state.weatherCubitModel.latitude,
      longitude: state.weatherCubitModel.longitude,
    );
  }

  void toggleUnits() {
    final units = state.temperatureUnits.isFahrenheit
        ? TemperatureUnits.celsius
        : TemperatureUnits.fahrenheit;

    if (state.status != WeatherStatus.success) {
      emit(state.copyWith(temperatureUnits: units));
      return;
    }

    final weather = state.weatherCubitModel;
    if (weather != WeatherCubitModel.empty) {
      final temperature = weather.temperature;
      final value = units.isCelsius
          ? temperature.value.toCelsius()
          : temperature.value.toFahrenheit();

      emit(
        state.copyWith(
          temperatureUnits: units,
          weatherCubitModel: weather.copyWith(
            temperature: Temperature(value: value),
          ),
        ),
      );
    }
  }

  Future<void> _getWeather({
    required double latitude,
    required double longitude,
  }) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final res = await _weatherRepository.getWeather(
        latitude: latitude,
        longitude: longitude,
      );

      res.fold(
        (onError) {
          emit(
            state.copyWith(
              status: WeatherStatus.failure,
              errorMessage: onError.error.toString(),
            ),
          );
        },
        (onOk) {
          final weather = onOk.value;
          final weatherCubitModel = WeatherCubitModel.fromRepository(weather);

          final units = state.temperatureUnits;
          final value = units.isFahrenheit
              ? weatherCubitModel.temperature.value.toFahrenheit()
              : weatherCubitModel.temperature.value;

          emit(
            state.copyWith(
              status: WeatherStatus.success,
              temperatureUnits: units,
              weatherCubitModel: weatherCubitModel.copyWith(
                temperature: Temperature(value: value),
              ),
            ),
          );
        },
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: WeatherStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  WeatherState? fromJson(Map<String, dynamic> json) =>
      WeatherState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(WeatherState state) => state.toJson();
}

extension TemperatureConversion on double {
  double toFahrenheit() => (this * 9 / 5) + 32;
  double toCelsius() => (this - 32) * 5 / 9;
}

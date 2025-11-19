import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/presentation/cubit/model/weather_cubit_model.dart';

import '/domain/repository/weather_repository.dart';

part 'weather_state.dart';
part 'weather_cubit.g.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherCubit(this._weatherRepository) : super(WeatherState());

  Future<void> fetchWeather(double latitude, double longitude) async {
    _getWeather(latitude, longitude);
  }

  Future<void> refreshWeather() async {
    if (!state.status.isSuccess) return;

    if (state.weatherCubitModel == WeatherCubitModel.empty) return;

    _getWeather(
      state.weatherCubitModel.latitude,
      state.weatherCubitModel.longitude,
    );
  }

  void toggleUnits() {
    final units = state.temperatureUnits.isFahrenheit
        ? TemperatureUnits.celsius
        : TemperatureUnits.fahrenheit;

    if (!state.status.isSuccess) {
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
          weatherCubitModel: weather.copyWith(temperature: Temperature(value: value)),
        ),
      );
    }
  }

  Future<void> _getWeather(double latitude, double longitude) async {

    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final weather = WeatherCubitModel.fromRepository(
        await _weatherRepository.getWeather(
         latitude,
          longitude,
        ),
      );

      final units = state.temperatureUnits;
      final value = units.isFahrenheit
        ? weather.temperature.value.toFahrenheit()
        : weather.temperature.value;

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weatherCubitModel: weather.copyWith(
            temperature: Temperature(value: value)
          ),
        ),
      );
    } on Exception {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }
}

extension TemperatureConversion on double {
  double toFahrenheit() => (this * 9 / 5) + 32;
  double toCelsius() => (this - 32) * 5 / 9;
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weather_app/data/repository/weather_repository_impl.dart';
import 'package:weather_app/presentation/cubit/model/weather_cubit_model.dart';

part 'weather_state.dart';
part 'weather_cubit.g.dart';

class WeatherCubit extends HydratedCubit<WeatherState> {
  final WeatherRepositoryImpl _weatherRepositoryImpl;

  WeatherCubit(this._weatherRepositoryImpl) : super(WeatherState());

  Future<void> fetchWeather(double latitude, double longitude) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final weather = WeatherCubitModel.fromRepository(
        await _weatherRepositoryImpl.getWeather(latitude, longitude),
      );

      final units = state.temperatureUnits;
      final value = units.isFahrenheit
        ? weather.temperature.value.toFahrenheit()
        : weather.temperature.value.toCelsius();

      emit(state.copyWith(
        status: WeatherStatus.success,
        temperatureUnits: units,
        weatherCubitModel: weather.copyWith(
            temperature: Temperature(value: value),
        )
      ));

    } catch (e) {
      emit(state.copyWith(status: WeatherStatus.failure));
    }

  }

  Future<void> refreshWeather() async {
    if (!state.status.isSuccess) return;
    if (state.weatherCubitModel == WeatherCubitModel.empty) return;
    try {
      final weather = WeatherCubitModel.fromRepository(
        await _weatherRepositoryImpl.getWeather(state.weatherCubitModel.latitude, state.weatherCubitModel.longitude),
      );
      final units = state.temperatureUnits;
      final value = units.isFahrenheit
          ? weather.temperature.value.toFahrenheit()
          : weather.temperature.value;

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weatherCubitModel: weather.copyWith(temperature: Temperature(value: value)),
        ),
      );
    } on Exception {
      emit(state);
    }
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

  @override
  WeatherState? fromJson(Map<String, dynamic> json) =>
      WeatherState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(WeatherState state) =>
      state.toJson();
}

extension TemperatureConversion on double {
  double toFahrenheit() => (this * 9 / 5) + 32;
  double toCelsius() => (this - 32) * 5 / 9;
}

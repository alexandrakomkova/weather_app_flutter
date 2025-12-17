import 'package:weather_app/presentation/cubit/model/weather_cubit_model.dart';

abstract class AIApiClient {
  Future<String> getClothesRecommendation({
    required WeatherCubitModel weather,
    required TemperatureUnits temperatureUnits,
  });
  void close();
}
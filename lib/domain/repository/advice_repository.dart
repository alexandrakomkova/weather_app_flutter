import 'package:weather_app/presentation/cubit/model/weather_cubit_model.dart';
import 'package:weather_app/utils/result.dart';

abstract class AdviceRepository {
  Future<Result<String>> getClothesRecommendation({
    required WeatherCubitModel weather,
    required TemperatureUnits temperatureUnits,
  });

  void dispose();
}

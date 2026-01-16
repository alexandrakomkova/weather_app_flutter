import 'package:weather_app/domain/model/weather.dart';
import 'package:weather_app/utils/result.dart';

abstract class WeatherRepository {
  Future<Result<Weather>> getWeather({
    required double latitude,
    required double longitude,
  });

  void dispose();
}

import 'package:weather_app/domain/model/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather({
    required double latitude,
    required double longitude,
  });
}
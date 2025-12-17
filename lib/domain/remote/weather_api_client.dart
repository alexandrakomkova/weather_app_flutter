import 'package:weather_app/domain/model/weather.dart';

abstract class WeatherApiClient {
  Future<Weather> getWeather(double latitude, double longitude);
  void close();
}
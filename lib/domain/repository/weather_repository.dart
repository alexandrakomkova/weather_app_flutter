import 'package:weather_app/domain/model/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather(double latitude, double longitude);
}
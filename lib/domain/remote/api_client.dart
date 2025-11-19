import 'package:weather_app/domain/model/weather.dart';

abstract class ApiClient {
  Future<Weather> getWeather(double latitude, double longitude);
  void close();
}
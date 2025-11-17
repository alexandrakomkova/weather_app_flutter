import 'package:weather_app/domain/model/weather_repository_model.dart';

abstract class WeatherRepository {
  Future<WeatherRepositoryModel> getWeather(double latitude, double longitude);
}
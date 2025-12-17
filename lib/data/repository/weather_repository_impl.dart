
import 'package:weather_app/domain/remote/weather_api_client.dart';
import 'package:weather_app/domain/repository/weather_repository.dart';

import 'package:weather_app/domain/model/weather.dart';

class WeatherRepositoryImpl implements WeatherRepository{
  final WeatherApiClient _apiClient;

  WeatherRepositoryImpl({
    required WeatherApiClient apiClient,
  }): _apiClient = apiClient;

  @override
  Future<Weather> getWeather(double latitude, double longitude) async {
    return await _apiClient.getWeather(latitude, longitude);
  }

  void dispose() => _apiClient.close();
}
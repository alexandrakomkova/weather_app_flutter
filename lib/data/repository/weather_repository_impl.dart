
import 'package:weather_app/domain/remote/api_client.dart';
import 'package:weather_app/domain/repository/weather_repository.dart';

import 'package:weather_app/domain/model/weather.dart';

class WeatherRepositoryImpl implements WeatherRepository{
  final ApiClient _apiClient;

  WeatherRepositoryImpl({
    required ApiClient apiClient,
  }): _apiClient = apiClient;

  @override
  Future<Weather> getWeather(double latitude, double longitude) async {
    return await _apiClient.getWeather(latitude, longitude);
  }

  void dispose() => _apiClient.close();
}
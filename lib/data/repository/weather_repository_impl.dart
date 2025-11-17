
import 'package:weather_app/data/remote/open_meteo_api.dart';
import 'package:weather_app/domain/repository/weather_repository.dart';

import '../../domain/model/weather_repository_model.dart';
import '../../domain/model/weather_condition.dart';
import '../model/weather_response.dart';

class WeatherRepositoryImpl implements WeatherRepository{
  final OpenMeteoApiClient _openMeteoApiClient;

  WeatherRepositoryImpl({
    OpenMeteoApiClient? openMeteoApiClient,
}): _openMeteoApiClient = openMeteoApiClient ?? OpenMeteoApiClient();

  @override
  Future<WeatherRepositoryModel> getWeather(double latitude, double longitude) async {
    final WeatherResponse weather = await _openMeteoApiClient.getWeather(
        latitude: latitude,
        longitude: longitude,
    );

    return WeatherRepositoryModel(
        latitude: 0.0,
        longitude: 0.0,
        temperature: weather.temperature,
        weatherCondition: weather.weatherCode.toInt().toCondition,
    );
  }

  void dispose() => _openMeteoApiClient.close();
}

extension on int {
  WeatherCondition get toCondition {
    switch (this) {
      case 0:
        return WeatherCondition.clear;
      case 1:
      case 2:
      case 3:
      case 45:
      case 48:
        return WeatherCondition.cloudy;
      case 51:
      case 53:
      case 55:
      case 56:
      case 57:
      case 61:
      case 63:
      case 65:
      case 66:
      case 67:
      case 80:
      case 81:
      case 82:
      case 95:
      case 96:
      case 99:
        return WeatherCondition.rainy;
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return WeatherCondition.snowy;
      default:
        return WeatherCondition.unknown;
    }
  }
}

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
        latitude: latitude,
        longitude: longitude,
        temperature: weather.temperature,
        weatherCondition: weather.weatherCode.toInt().toCondition,
        windSpeed: weather.windSpeed,
        windDirection: weather.windDirection.toInt().toNamedDirection,
        isDay: weather.isDay,
    );
  }

  void dispose() => _openMeteoApiClient.close();
}

extension on int {
  String get toNamedDirection {
    switch (this) {
      case 0:
      case 360:
        return 'North';
      case > 0 && < 45:
        return 'North-Northeast';
      case 45:
        return 'North-East';
      case > 45 && < 90:
        return 'East-Northeast';
      case 90:
        return 'East';
      case > 90 && < 135:
        return 'East-Southeast';
      case 135:
        return 'South-East';
      case > 135 && < 180:
        return 'South-Southeast';
      case 180:
        return 'South';
      case > 180 && < 225:
        return 'South-Southwest';
      case 225:
        return 'South-West';
      case > 225 && < 270:
        return 'West-Southwest';
      case 270:
        return 'West';
      case > 270 && < 315:
        return 'West-Northwest';
      case 315:
        return 'North-West';
      case > 315 && < 360:
        return 'North-northwest';
      default:
        return 'Unknown';
    }
  }
}

extension on int {
  WeatherCondition get toCondition {
    switch (this) {
      case 0:
        return WeatherCondition.clear;
      case 1:
      case 2:
      case 3:
        return WeatherCondition.mainlyClear;
      case 45:
      case 48:
        return WeatherCondition.cloudy;
      case 51:
      case 53:
      case 55:
        return WeatherCondition.drizzle;
      case 56:
      case 57:
        return WeatherCondition.freezingDrizzle;
      case 61:
      case 63:
      case 65:
      case 66:
      case 67:
      return WeatherCondition.rainy;
      case 80:
      case 81:
      case 82:
        return WeatherCondition.rainShowers;
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return WeatherCondition.snowy;
      case 95:
      case 96:
      case 99:
        return WeatherCondition.thunderstorm;
      default:
        return WeatherCondition.unknown;
    }
  }
}
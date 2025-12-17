import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/constants.dart';
import 'package:weather_app/data/model/weather_response.dart';
import 'package:weather_app/domain/model/weather.dart';
import 'package:weather_app/domain/model/weather_condition.dart';
import 'package:weather_app/domain/remote/weather_api_client.dart';

class OpenMeteoApiClient implements WeatherApiClient{
  final http.Client _httpClient;

  OpenMeteoApiClient({
    http.Client? httpClient
  }): _httpClient = httpClient ?? http.Client();

  @override
  Future<Weather> getWeather(double latitude, double longitude) async {
    final weatherRequest = Uri.https(baseUrlOpenMeteo, 'v1/forecast', {
          'latitude': '$latitude',
          'longitude': '$longitude',
          'current_weather': 'true',
    });

    final weatherResponse = await _httpClient.get(weatherRequest);

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    final bodyJson = jsonDecode(weatherResponse.body) as Map<String, dynamic>;

    if (!bodyJson.containsKey('current_weather')) {
       throw WeatherNotFoundFailure();
    }

    final weatherJson = bodyJson['current_weather'] as Map<String, dynamic>;
    final weather = WeatherResponse.fromJson(weatherJson);

    return Weather(
        latitude: latitude,
        longitude: longitude, 
        temperature: weather.temperature,
        windSpeed: weather.windSpeed,
        windDirection: weather.windDirectionAngle.toDirection,
        weatherCondition: weather.weatherConditionCode.toInt().toCondition,
    );
  }

  @override
  void close() {
    _httpClient.close();
  }
}

extension on int {
  String get toDirection {
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

// class LocationRequestFailure implements Exception {}
// class LocationNotFoundFailure implements Exception {}
class WeatherRequestFailure implements Exception {}
class WeatherNotFoundFailure implements Exception {}
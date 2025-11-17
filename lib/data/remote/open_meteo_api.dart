import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/constants.dart';
import 'package:weather_app/data/model/weather_response.dart';

class OpenMeteoApiClient {
  final http.Client _httpClient;

  OpenMeteoApiClient({
    http.Client? httpClient
  }): _httpClient = httpClient ?? http.Client();

  Future<WeatherResponse> getWeather({
    required double latitude,
    required double longitude,
  }) async {
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

    return WeatherResponse.fromJson(weatherJson);

  }

  void close() {
    _httpClient.close();
  }
}

class LocationRequestFailure implements Exception {}
class LocationNotFoundFailure implements Exception {}
class WeatherRequestFailure implements Exception {}
class WeatherNotFoundFailure implements Exception {}
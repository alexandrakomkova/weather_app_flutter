import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/constants.dart';
import 'package:weather_app/data/model/advice_response.dart';
import 'package:weather_app/domain/remote/ai_api_client.dart';
import 'package:weather_app/presentation/cubit/model/weather_cubit_model.dart';

class ClarifaiApiClient implements AIApiClient {
  final http.Client _httpClient;

  ClarifaiApiClient({
    http.Client? httpClient
  }): _httpClient = httpClient ?? http.Client();

  @override
  void close() {
    _httpClient.close();
  }

  @override
  Future<String> getClothesRecommendation({
    required WeatherCubitModel weather,
    required TemperatureUnits temperatureUnits,
  }) async {
    final url = Uri.parse(clarifaiUrl);
    final apiKey = dotenv.env['CLARIFAI_API_KEY'];

    final clarifaiResponse = await http.post(
      url,
      headers: <String, String> {
        'Authorization': 'Key $apiKey',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: _formRequestBody(
        weather: weather,
        temperatureUnits: temperatureUnits,
      ),
    );

    if(clarifaiResponse.statusCode != 200) {
      throw ClarifaiApiRequestFailure();
    }

    final bodyJson = jsonDecode(clarifaiResponse.body) as Map<String, dynamic>;
    if (!bodyJson.containsKey('outputs')) {
      throw ClarifaiApiOutputNotFound();
    }

    final adviceJson = bodyJson['outputs'][0]['data'] as Map<String, dynamic>;
    final advice = AdviceResponse.fromJson(adviceJson);

    return advice.advice;
  }

  String _formRequestBody({
    required WeatherCubitModel weather,
    required TemperatureUnits temperatureUnits,
  }) {
    final weatherCondition = weather.weatherCondition.condition;
    final temperature = weather.temperature;
    final windSpeed = weather.windSpeed;
    final windDirection = weather.windDirection;
    final units = '°${temperatureUnits.isCelsius ? 'C' : 'F'}';

    return jsonEncode(<String, dynamic>{
      'inputs': [{
        'data': {
          'text': {
            'raw': 'You are a great synoptic. Give a user a short piece of advice about what to wear if the weather is $weatherCondition, the temperature is $temperature $units, the wind speed is $windSpeed km/h and the wind direction is $windDirection.'
          }
        }
      }]
    });
  }
}

class ClarifaiApiRequestFailure implements Exception {}
class ClarifaiApiOutputNotFound implements Exception {}
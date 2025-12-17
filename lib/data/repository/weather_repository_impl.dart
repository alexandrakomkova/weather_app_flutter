
import 'package:logging/logging.dart';
import 'package:weather_app/data/remote/open_meteo_api.dart';
import 'package:weather_app/domain/remote/weather_api_client.dart';
import 'package:weather_app/domain/repository/weather_repository.dart';

import 'package:weather_app/domain/model/weather.dart';
import 'package:weather_app/utils/result.dart';

final _log = Logger('WeatherRepositoryImpl');
class WeatherRepositoryImpl implements WeatherRepository{
  final WeatherApiClient _apiClient;

  WeatherRepositoryImpl({
    required WeatherApiClient apiClient,
  }): _apiClient = apiClient;

  @override
  Future<Result<Weather>> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final res = await _apiClient.getWeather(latitude, longitude);
      return Result.ok(res);
    } on WeatherRequestFailure {
      final message = 'Can not processed a request. Please, try later.';
      _log.warning(message);
      return Result.error(WeatherRequestFailure(message: message));
    } on WeatherNotFoundFailure {
      final message = 'Can not parse a request body. Please, try later.';
      _log.warning(message);
      return Result.error(WeatherNotFoundFailure(message: message));
    } on Exception catch(e) {
      return Result.error(Exception('Unexpected error occurred: $e'));
    }
  }

  void dispose() => _apiClient.close();
}
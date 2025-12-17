
import 'package:logging/logging.dart';
import 'package:weather_app/domain/remote/weather_api_client.dart';
import 'package:weather_app/domain/repository/weather_repository.dart';

import 'package:weather_app/domain/model/weather.dart';
import 'package:weather_app/utils/custom_exception.dart';
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
    } on WeatherRequestFailure catch(e) {
      _log.warning(e.message);
      return Result.error(WeatherRequestFailure());
    } on WeatherNotFoundFailure catch(e) {
      _log.warning(e);
      return Result.error(WeatherNotFoundFailure());
    } on Exception catch(e) {
      return Result.error(Exception('Unexpected error occurred: $e'));
    }
  }

  void dispose() => _apiClient.close();
}
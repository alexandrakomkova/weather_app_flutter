import 'package:logging/logging.dart';
import 'package:weather_app/domain/remote/ai_api_client.dart';
import 'package:weather_app/domain/repository/advice_repository.dart';
import 'package:weather_app/presentation/cubit/model/weather_cubit_model.dart';
import 'package:weather_app/utils/custom_exception.dart';
import 'package:weather_app/utils/result.dart';

final _log = Logger('AdviceRepositoryImpl');
class AdviceRepositoryImpl implements AdviceRepository {
  final AIApiClient _apiClient;
  AdviceRepositoryImpl({
    required AIApiClient apiClient,
  }): _apiClient = apiClient;

  @override
  Future<Result<String>> getClothesRecommendation({
    required WeatherCubitModel weather,
    required TemperatureUnits temperatureUnits,
  }) async {
    try {
      final res = await _apiClient.getClothesRecommendation(
        weather: weather,
        temperatureUnits: temperatureUnits,
      );

      return Result.ok(res);
    } on ClarifaiApiRequestFailure catch(e) {
      _log.warning(e.message);
      return Result.error(ClarifaiApiRequestFailure());
    } on ClarifaiApiOutputNotFound catch(e) {
      _log.warning(e.message);
      return Result.error(ClarifaiApiOutputNotFound());
    } on Exception catch(e) {
      _log.warning(e.toString());
      return Result.error(Exception('Some error occurred. Please, try later.'));
    }
  }

  void dispose() => _apiClient.close();
}
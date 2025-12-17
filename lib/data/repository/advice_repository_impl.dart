import 'package:weather_app/data/remote/clarifai_api.dart';
import 'package:weather_app/domain/remote/ai_api_client.dart';
import 'package:weather_app/domain/repository/advice_repository.dart';
import 'package:weather_app/presentation/cubit/model/weather_cubit_model.dart';

class AdviceRepositoryImpl implements AdviceRepository {
  final AIApiClient _apiClient;
  AdviceRepositoryImpl({
    required AIApiClient apiClient,
  }): _apiClient = apiClient;

  @override
  Future<String> getClothesRecommendation({
    required WeatherCubitModel weather,
    required TemperatureUnits temperatureUnits,
  }) async {
    try {
      return await _apiClient.getClothesRecommendation(
        weather: weather,
        temperatureUnits: temperatureUnits,
      );
    } on ClarifaiApiRequestFailure catch(e) {
      return 'Can not processed a request. Please, try later.';
    } on ClarifaiApiOutputNotFound catch(e) {
      return 'Can not parse a request body. Please, try later.';
    } on Exception catch(e) {
      return 'Some error occurred. Please, try later.';
    }
  }

  void dispose() => _apiClient.close();
}
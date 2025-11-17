
import 'package:geolocator/geolocator.dart';
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
    final pos = await _determinePosition();

    final WeatherResponse weather = await _openMeteoApiClient.getWeather(
        latitude: pos.latitude,
        longitude: pos.longitude,
    );

    return WeatherRepositoryModel(
        latitude: pos.latitude,
        longitude: pos.longitude,
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

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
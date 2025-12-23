import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:home_widget/home_widget.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/location/location_repository_impl.dart';
import 'package:weather_app/data/remote/open_meteo_api.dart';
import 'package:weather_app/data/repository/weather_repository_impl.dart';
import 'package:weather_app/domain/model/weather.dart';
import 'package:weather_app/presentation/cubit/model/weather_cubit_model.dart';
import 'package:workmanager/workmanager.dart';

final _log = Logger('WidgetService');
const weatherWidgetReceiver = 'dev.alexandrakomkova.weather_app.WeatherWidgetReceiver';
const updateWeatherData = "dev.alexandrakomkova.weather_app.updateWeatherData";

class WidgetService {

  // iOS
  static const iOSWidgetAppGroupId = 'group.dev.alexandrakomkova.weather_app';
  static const weatherWidgetiOSName = 'WeatherWidgetReceiver';

  // Android
  static const androidPackagePrefix = 'dev.alexandrakomkova.weather_app';
  static const weatherWidgetAndroidName =
      '$androidPackagePrefix.WeatherWidgetReceiver';

  // Keys for storing data
  static const temperatureKey = 'temperature';
  static const temperatureUnitsKey = 'temperatureUnits';
  static const windSpeedKey = 'windSpeed';
  static const windDirectionKey = 'windDirection';
  static const weatherConditionsKey = 'weatherConditions';


  static Future<void> initialize() async {
    // await Workmanager().initialize(
    //     myCallbackDispatcher, // The top level function, aka callbackDispatcher
    //   isInDebugMode: true,
    // );

    HomeWidget.registerInteractivityCallback(interactiveCallback);

    if (kDebugMode) {
      _log.info('registerOneOffTask');
      Workmanager().registerOneOffTask("test_task_${DateTime.now().millisecondsSinceEpoch}", updateWeatherData);
    }

    await Workmanager().registerPeriodicTask(
      "updateWeatherWidget",
      updateWeatherData,
      frequency: const Duration(seconds: 20), // hours 1
      constraints: Constraints(networkType: NetworkType.connected, requiresBatteryNotLow: true),
    );
    // await HomeWidget.setAppGroupId(iOSWidgetAppGroupId);
  }

  static Future<void> syncWeatherDataToWidget(Weather data, TemperatureUnits units) async {
    await saveData(temperatureKey, data.temperature);
    await saveData(temperatureUnitsKey, units.isCelsius ? 'C' : 'F');
    await saveData(windSpeedKey, data.windSpeed);
    await saveData(windDirectionKey, data.windDirection);
    await saveData(weatherConditionsKey, data.weatherCondition);
  }


  static Future<void> saveData(String key, value) async {
    await _saveData(key, value);
    _log.info('Saved $key $value');
  }

  // Save data to Shared Preferences
  static Future<void> _saveData<T>(String key, T data) async {
    await HomeWidget.saveWidgetData<T>(key, data);
  }

  // Retrieve data from Shared Preferences
  static Future<T?> _getData<T>(String key) async {
    return await HomeWidget.getWidgetData<T>(key);
  }

  static Future<void> reloadWidgets() async {
    _updateWidget(
      iOSWidgetName: weatherWidgetiOSName,
      qualifiedAndroidName: weatherWidgetAndroidName,
    );
  }

  // Request to update widgets on both iOS and Android
  static Future<void> _updateWidget({
    String? iOSWidgetName,
    String? qualifiedAndroidName,
  }) async {
    final result = await HomeWidget.updateWidget(
      name: iOSWidgetName,
      iOSName: iOSWidgetName,
      qualifiedAndroidName: qualifiedAndroidName,
    );
    _log.info(
      '[WidgetService.updateWidget] iOSWidgetName: $iOSWidgetName, qualifiedAndroidName: $qualifiedAndroidName, result: $result'
    );
  }
}

@pragma('vm:entry-point')
void myCallbackDispatcher() {
  _log.info('myCallbackDispatcher');
  Workmanager().executeTask((task, inputData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    switch(task) {
      case updateWeatherData:
        try {
          final List<HomeWidgetInfo> installedWidgets = await HomeWidget.getInstalledWidgets();
          _log.info('${installedWidgets.length} installed widgets');

          if (installedWidgets.isEmpty) {
            _log.info('no widgets installed, skipping update');
            return Future.value(true);
          }

          for (HomeWidgetInfo widgetInfo in installedWidgets) {

            final String widgetClassName = widgetInfo.androidClassName!;

            final Position position = await LocationRepositoryImpl().getLocation();
            final latitude = position.latitude;
            final longitude = position.longitude;

            _log.info('location: $latitude $longitude');
            _log.info('weatherWidgetReceiver: $weatherWidgetReceiver');
            _log.info('widgetClassName: $widgetClassName');


            if(weatherWidgetReceiver == widgetClassName) {
              final weatherResult = await WeatherRepositoryImpl(
                  apiClient: OpenMeteoApiClient()
              ).getWeather(
                latitude: latitude,
                longitude: longitude,
              );

              weatherResult.fold(
                (onError) {
                  _log.warning(onError.error.toString());
                  return Future.value(false);
                },
                (onOk) async {
                  Weather data = onOk.value;
                  _log.info('${onOk.value.temperature}C ${onOk.value.windSpeed}km/h');
                  await WidgetService.syncWeatherDataToWidget(data, TemperatureUnits.celsius);
                }
              );
            }
          }

          WidgetService.reloadWidgets();
        } catch(e) {
          _log.warning(e.toString());
          return Future.value(false);
        }
    }
    return Future.value(true);
  });
}

@pragma('vm:entry-point')
Future<void> interactiveCallback(Uri? uri) async {
  _log.info("INTERACTIVE CALLBACK, ${uri.toString()}");
  if (uri?.host == 'update') {
    await Workmanager().registerOneOffTask(
        "test_task_${DateTime.now().millisecondsSinceEpoch}", updateWeatherData);
  }
}
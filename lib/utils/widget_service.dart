import 'package:home_widget/home_widget.dart';
import 'package:logging/logging.dart';

final _log = Logger('WidgetService');
class WidgetService {
  // iOS
  static const iOSWidgetAppGroupId = 'group.dev.alexandrakomkova.weather_app';
  static const streakWidgetiOSName = 'WeatherWidget';

  // Android
  static const androidPackagePrefix = 'dev.alexandrakomkova.weather_app';
  static const streakWidgetAndroidName =
      '$androidPackagePrefix.weather_app_widget.WeatherWidgetReceiver';

  // Keys for storing data
  static const temperatureKey = 'temperature';
  static const temperatureUnitsKey = 'temperatureUnits';
  static const windSpeedKey = 'windSpeed';
  static const windDirectionKey = 'windDirection';
  static const weatherConditionsKey = 'weatherConditions';

  static Future<void> initialize() async {
    await HomeWidget.setAppGroupId(iOSWidgetAppGroupId);
  }

  // Update dark mode
  // static Future<void> updateDarkMode(bool isDarkMode) async {
  //   await _saveData<bool>(darkModeKey, isDarkMode);
  //   _updateWidget(
  //     iOSWidgetName: streakWidgetiOSName,
  //     qualifiedAndroidName: streakWidgetAndroidName,
  //   );
  // }


  // Save data to Shared Preferences
  static Future<void> _saveData<T>(String key, T data) async {
    await HomeWidget.saveWidgetData<T>(key, data);
  }

  // Retrieve data from Shared Preferences
  static Future<T?> _getData<T>(String key) async {
    return await HomeWidget.getWidgetData<T>(key);
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
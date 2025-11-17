import 'package:flutter/material.dart';
import 'package:weather_app/presentation/cubit/model/weather_cubit_model.dart';

class WeatherView extends StatelessWidget {
  final WeatherCubitModel weatherCubitModel;
  final TemperatureUnits units;
  final ValueGetter<Future<void>> onRefresh;

  const WeatherView({
    required this.weatherCubitModel,
    required this.units,
    required this.onRefresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: onRefresh,
            child: Align(
              alignment: const Alignment(0, -1 / 3),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                  clipBehavior: Clip.none,
                  child: Column(
                    children: [
                      Text('${weatherCubitModel.latitude} ${weatherCubitModel.longitude}'),
                      Text('Wind Speed: ${weatherCubitModel.windSpeed}'),
                      Text('Wind direction: ${weatherCubitModel.windDirection}'),
                      Text('day: ${weatherCubitModel.isDay}'),
                      Text(weatherCubitModel.formattedTemperature(units) ),
                      Text('''Last Updated at ${TimeOfDay.fromDateTime(weatherCubitModel.lastUpdated).format(context)}'''),
                    ],
                  ),
              ),
            ),
        )
      ],
    );
  }
}

extension on WeatherCubitModel {
  String formattedTemperature(TemperatureUnits units) {
    return '''${temperature.value.toStringAsPrecision(2)}°${units.isCelsius ? 'C' : 'F'}''';
  }
}


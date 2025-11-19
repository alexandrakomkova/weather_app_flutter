import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/cubit/address_tracker/address_tracker_cubit.dart';
import 'package:weather_app/presentation/cubit/model/weather_cubit_model.dart';

import '/domain/model/weather_condition.dart';


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
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 1.5 * kToolbarHeight, 30, 20),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            _WeatherBackground(
              weatherCondition: weatherCubitModel.condition,
            ),
            RefreshIndicator(
              onRefresh: onRefresh,
              child: Align(
                alignment: const Alignment(0, -1 / 3),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  clipBehavior: Clip.none,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<AddressTrackerCubit, AddressTrackerState>(
                          builder: (context, state) {
                            return Text(
                              '📍${state.address}',
                              style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w300
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Monday',
                          style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Image.asset(
                          weatherCubitModel.condition.toImagePath,
                        ),

                        Center(
                          child: Text(
                            weatherCubitModel.formattedTemperature(units),
                            style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontSize: 55,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                              '''Last Updated at ${TimeOfDay.fromDateTime(weatherCubitModel.lastUpdated).format(context)}''',
                            style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                        ),

                        const SizedBox(height: 30.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _WeatherParamsCard(
                              cardIcon: 'assets/wind_speed.png',
                              cardTitle: 'Wind Speed',
                              value: '${weatherCubitModel.windSpeed} km/h',
                            ),
                            _WeatherParamsCard(
                              cardIcon: 'assets/wind_direction.png',
                              cardTitle: 'Wind Direction',
                              value: weatherCubitModel.windDirection,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension on WeatherCubitModel {
  String formattedTemperature(TemperatureUnits units) {
    return '''${temperature.value.toStringAsPrecision(2)}°${units.isCelsius ? 'C' : 'F'}''';
  }
}

class _WeatherParamsCard extends StatelessWidget {
  final String cardIcon;
  final String cardTitle;
  final String value;

  const _WeatherParamsCard({
    required this.cardIcon,
    required this.cardTitle,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Image.asset(
            cardIcon,
          scale: 13.0,
          color: theme.colorScheme.primary,
        ),
        SizedBox(width: 12.0,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cardTitle,
              style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w300,
                  fontSize: 14
              ),
            ),
            SizedBox(height: 3.0,),
            Text(
              value,
              style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                fontSize: 14
              ),
            ),
          ],
        )
      ],
    );
  }
}


class _WeatherBackground extends StatelessWidget {
  final WeatherCondition weatherCondition;

  const _WeatherBackground({
    required this.weatherCondition,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(2, -0.1),
            child: Container(
              height: 350,
              width: 250,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: weatherCondition.thirdColor
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(-4, -0.1),
            child: Container(
              height: 300 ,
              width: 300,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: weatherCondition.secondColor
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0, -1.2),
            child: Container(
              height: 350,
              width: 600,
              decoration: BoxDecoration(
                  color: weatherCondition.mainColor
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
            child: Container(
              decoration: const BoxDecoration(color: Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }
}

extension on WeatherCondition {
  String get toImagePath {
    switch (this) {
      case WeatherCondition.clear:
       return 'assets/clear.png';
      case WeatherCondition.mainlyClear:
        return 'assets/mainly_clear.png';
      case WeatherCondition.rainy:
        return 'assets/rainy.png';
      case WeatherCondition.rainShowers:
        return 'assets/rain_showers.png';
      case WeatherCondition.cloudy:
        return 'assets/cloudy.png';
      case WeatherCondition.thunderstorm:
        return 'assets/thunderstorm.png';
      case WeatherCondition.drizzle:
        return 'assets/drizzle.png';
      case WeatherCondition.freezingDrizzle:
        return 'assets/freezing_drizzle.png';
      case WeatherCondition.snowy:
        return 'assets/snowy.png';
      case WeatherCondition.unknown:
        return 'assets/cloudy.png';
    }
  }
}

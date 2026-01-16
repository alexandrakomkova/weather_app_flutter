import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/model/weather_condition.dart';
import 'package:weather_app/presentation/cubit/address_tracker/address_tracker_cubit.dart';
import 'package:weather_app/presentation/cubit/ai_advice/advice_cubit.dart';
import 'package:weather_app/presentation/cubit/model/weather_cubit_model.dart';
import 'package:weather_app/presentation/cubit/weather/weather_cubit.dart';
import 'package:weather_app/presentation/widgets/clothes_recommendation_card.dart';
import 'package:weather_app/presentation/widgets/weather_params_card.dart';

class WeatherCard extends StatefulWidget {
  final WeatherCubitModel weatherCubitModel;
  final TemperatureUnits units;
  final ValueGetter<Future<void>> onRefresh;

  const WeatherCard({
    required this.weatherCubitModel,
    required this.units,
    required this.onRefresh,
    super.key,
  });

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(count: 3, reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.02).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        _WeatherBackground(
          weatherCondition: widget.weatherCubitModel.weatherCondition,
        ),
        RefreshIndicator(
          onRefresh: widget.onRefresh,
          child: Align(
            alignment: const Alignment(0, -1 / 3),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              clipBehavior: Clip.none,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<AddressTrackerCubit, AddressTrackerState>(
                    builder: (_, state) {
                      return Row(
                        children: [
                          Expanded(
                            child: Text(
                              '📍${state.address}',
                              style: theme.textTheme.bodyLarge!.copyWith(
                                color: theme.colorScheme.primary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    DateFormat('EEEE').format(DateTime.now()),
                    style: theme.textTheme.headlineMedium!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  ScaleTransition(
                    scale: _animation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          widget.weatherCubitModel.weatherCondition.icon,
                          scale: 1.7,
                        ),
                      ],
                    ),
                  ),

                  Center(
                    child: Text(
                      widget.weatherCubitModel.formattedTemperature(
                        widget.units,
                      ),
                      style: theme.textTheme.headlineLarge!.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '''Last Updated at ${TimeOfDay.fromDateTime(widget.weatherCubitModel.lastUpdated).format(context)}''',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WeatherParamsCard(
                        cardIcon: 'assets/wind_speed.png',
                        cardTitle: 'Wind Speed',
                        value: '${widget.weatherCubitModel.windSpeed} km/h',
                      ),
                      WeatherParamsCard(
                        cardIcon: 'assets/wind_direction.png',
                        cardTitle: 'Wind Direction',
                        value: widget.weatherCubitModel.windDirection,
                      ),
                    ],
                  ),

                  const SizedBox(height: 30.0),

                  BlocListener<WeatherCubit, WeatherState>(
                    listener: (context, state) {
                      if (state.weatherCubitModel != WeatherCubitModel.empty) {
                        context.read<AdviceCubit>().fetchRecommendation(
                          weather: state.weatherCubitModel,
                          temperatureUnits: state.temperatureUnits,
                        );
                      }
                    },
                    child: const ClothesRecommendationCard(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

extension on WeatherCubitModel {
  String formattedTemperature(TemperatureUnits units) {
    return '''${temperature.value.toStringAsPrecision(2)}°${units.isCelsius ? 'C' : 'F'}''';
  }
}

class _WeatherBackground extends StatelessWidget {
  final WeatherCondition weatherCondition;

  const _WeatherBackground({required this.weatherCondition});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(2, -0.1),
            child: SizedBox(
              height: 350,
              width: 250,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: weatherCondition.thirdColor,
                ),
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(-4, -0.1),
            child: SizedBox(
              height: 300,
              width: 300,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: weatherCondition.secondColor,
                ),
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0, -1.2),
            child: SizedBox(
              height: 350,
              width: 600,
              child: DecoratedBox(
                decoration: BoxDecoration(color: weatherCondition.mainColor),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
            child: const DecoratedBox(
              decoration: BoxDecoration(color: Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }
}

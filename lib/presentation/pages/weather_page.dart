import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/cubit/weather_cubit.dart';
import 'package:weather_app/presentation/pages/weather_view.dart';

import '../widgets/weather_empty.dart';
import '../widgets/weather_error.dart';
import '../widgets/weather_loading.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              return switch (state.status) {
                WeatherStatus.initial => const WeatherEmpty(),
                WeatherStatus.loading => const WeatherLoading(),
                WeatherStatus.failure => const WeatherError(),
                WeatherStatus.success => WeatherView(
                  weatherCubitModel: state.weatherCubitModel,
                  units: state.temperatureUnits,
                  onRefresh: () {
                    return context.read<WeatherCubit>().refreshWeather();
                  }
                ),
              };
            }
        ),
      ),
    );
  }
}

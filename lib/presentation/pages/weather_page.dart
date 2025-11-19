import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/cubit/address_tracker/address_tracker_cubit.dart';
import 'package:weather_app/presentation/cubit/location/location_cubit.dart';
import 'package:weather_app/presentation/cubit/weather/weather_cubit.dart';
import 'package:weather_app/presentation/pages/weather_view.dart';

import '/presentation/widgets/weather_empty.dart';
import '/presentation/widgets/weather_error.dart';
import '/presentation/widgets/weather_loading.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationCubit, LocationState>(
        listener: (locationCubitContext, state) {
          if(state.status == LocationStatus.success && state.position != null) {
            locationCubitContext.read<AddressTrackerCubit>().getAddress(
              state.position!.latitude,
              state.position!.longitude,
            );
            locationCubitContext.read<WeatherCubit>().fetchWeather(
                state.position!.latitude,
                state.position!.longitude
            );
          }
        },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark
          ),
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 1.5 * kToolbarHeight, 30, 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: BlocBuilder<WeatherCubit, WeatherState>(
                builder: (weatherCubitContext, state) {
                  return switch (state.status) {
                    WeatherStatus.initial => const WeatherEmpty(),
                    WeatherStatus.loading => const WeatherLoading(),
                    WeatherStatus.failure => const WeatherError(),
                    WeatherStatus.success => WeatherView(
                      weatherCubitModel: state.weatherCubitModel,
                      units: state.temperatureUnits,
                      onRefresh: () {
                       return weatherCubitContext.read<WeatherCubit>().refreshWeather();
                       //  return weatherCubitContext.read<WeatherCubit>().fetchWeather(
                       //      state.weatherCubitModel.latitude,
                       //      state.weatherCubitModel.longitude,
                       //  );
                      }
                    ),
                  };
                }
              ),
            ),
        )
      )
    );
  }
}
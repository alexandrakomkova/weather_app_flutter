import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/cubit/address_tracker/address_tracker_cubit.dart';
import 'package:weather_app/presentation/cubit/location/location_cubit.dart';
import 'package:weather_app/presentation/cubit/weather/weather_cubit.dart';
import 'package:weather_app/presentation/pages/weather_view.dart';

import '../widgets/weather_empty.dart';
import '../widgets/weather_error.dart';
import '../widgets/weather_loading.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocListener<LocationCubit, LocationState>(
        listener: (context, state) {
          if(state.status == LocationStatus.success && state.position != null) {
            context.read<WeatherCubit>().fetchWeather(
                state.position!.latitude,
                state.position!.longitude
            );
            context.read<AddressTrackerCubit>().getAddress(
                state.position!.latitude,
              state.position!.longitude,
            );
          }
        },
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   child: const Icon(Icons.search, semanticLabel: 'Search'),
        //   onPressed: () async {
        //     // final city = await Navigator.of(context).push(SearchPage.route());
        //     if (!context.mounted) return;
        //     await context.read<WeatherCubit>().fetchWeather(0.0, 0.0);
        //   },
        // ),
        appBar: AppBar(
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark
          ),
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        body:
            Center(
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
      )
    );
  }
}
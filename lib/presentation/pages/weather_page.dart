import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/cubit/address_tracker/address_tracker_cubit.dart';
import 'package:weather_app/presentation/cubit/internet_connection/internet_cubit.dart';
import 'package:weather_app/presentation/cubit/location/location_cubit.dart';
import 'package:weather_app/presentation/cubit/weather/weather_cubit.dart';
import 'package:weather_app/presentation/widgets/weather_card.dart';
import 'package:weather_app/presentation/widgets/checking_internet_connection.dart';
import 'package:weather_app/presentation/widgets/no_internet_connection.dart';
import 'package:weather_app/presentation/widgets/weather_empty.dart';
import 'package:weather_app/presentation/widgets/weather_error.dart';
import 'package:weather_app/presentation/widgets/weather_loading.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<LocationCubit, LocationState>(
        listener: (locationCubitContext, state) {
          if(state.status == LocationStatus.success && state.position != null) {
            locationCubitContext.read<AddressTrackerCubit>().getAddress(
              latitude: state.position!.latitude,
              longitude: state.position!.longitude,
            );
            locationCubitContext.read<WeatherCubit>().fetchWeather(
              latitude: state.position!.latitude,
              longitude: state.position!.longitude
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
          actions: [
            BlocBuilder<WeatherCubit, WeatherState>(
              buildWhen: (previous, current) =>
                previous.temperatureUnits != current.temperatureUnits,
              builder: (weatherCubitContext, state) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text(
                        '°F',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 16
                        ),
                      ),
                      SizedBox(width: 3.0,),
                      Switch(
                        value: state.temperatureUnits.isCelsius,
                        onChanged: (_) => weatherCubitContext.read<WeatherCubit>().toggleUnits(),
                      ),
                      SizedBox(width: 3.0,),
                      Text(
                        '°C',
                        style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontSize: 16
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 2.2 * kToolbarHeight, 30, 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: BlocBuilder<InternetCubit, InternetState>(
                builder: (_, internetCubitState) {
                  return switch(internetCubitState.status) {
                    InternetStatus.loading => CheckingInternetConnection(),
                    InternetStatus.disconnected => NoInternetConnection(),
                    InternetStatus.connected => _WeatherView()
                  };
                },
              ),
            ),
        )
      )
    );
  }
}

class _WeatherView extends StatelessWidget {
  const _WeatherView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
        builder: (weatherCubitContext, weatherCubitState) {
          return switch (weatherCubitState.status) {
            WeatherStatus.initial => const WeatherEmpty(),
            WeatherStatus.loading => const WeatherLoading(),
            WeatherStatus.failure => const WeatherError(),
            WeatherStatus.success => WeatherCard(
                weatherCubitModel: weatherCubitState.weatherCubitModel,
                units: weatherCubitState.temperatureUnits,
                onRefresh: () {
                  return weatherCubitContext.read<WeatherCubit>().refreshWeather();
                }
            ),
          };
        }
    );
  }
}

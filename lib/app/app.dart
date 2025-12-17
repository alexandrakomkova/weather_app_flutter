import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/location/default_address_tracker.dart';
import 'package:weather_app/data/location/location_repository_impl.dart';
import 'package:weather_app/data/remote/clarifai_api.dart';
import 'package:weather_app/data/remote/open_meteo_api.dart';
import 'package:weather_app/data/repository/advice_repository_impl.dart';
import 'package:weather_app/data/repository/weather_repository_impl.dart';
import 'package:weather_app/presentation/cubit/address_tracker/address_tracker_cubit.dart';
import 'package:weather_app/presentation/cubit/ai_advice/advice_cubit.dart';
import 'package:weather_app/presentation/cubit/internet_connection/internet_cubit.dart';
import 'package:weather_app/presentation/cubit/location/location_cubit.dart';
import 'package:weather_app/presentation/cubit/weather/weather_cubit.dart';

import 'package:weather_app/presentation/pages/weather_page.dart';
import 'package:weather_app/presentation/theme/weather_theme.dart';

class App extends StatelessWidget {
  final Connectivity connectivity;

  const App({
    required this.connectivity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => OpenMeteoApiClient(),
          dispose: (apiClient) => apiClient.close(),
        ),
        RepositoryProvider(
          create: (_) => ClarifaiApiClient(),
          dispose: (apiClient) => apiClient.close(),
        ),
        RepositoryProvider(
          create: (_) => LocationRepositoryImpl(),
        ),
        RepositoryProvider(
          create: (_) => DefaultAddressTracker(),
        ),
        RepositoryProvider(
          create: (weatherRepositoryContext) => WeatherRepositoryImpl(
            apiClient: weatherRepositoryContext.read<OpenMeteoApiClient>()
          ),
          dispose: (repository) => repository.dispose(),
        ),
        RepositoryProvider(
          create: (adviceRepositoryContext) => AdviceRepositoryImpl(
            apiClient: adviceRepositoryContext.read<ClarifaiApiClient>()
          ),
          dispose: (repository) => repository.dispose(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LocationCubit>(
            create: (locationCubitContext) =>
              LocationCubit(locationCubitContext.read<LocationRepositoryImpl>())
          ),
          BlocProvider<AddressTrackerCubit>(
            create: (addressTrackerContext) =>
              AddressTrackerCubit(addressTrackerContext.read<DefaultAddressTracker>()),
          ),
          BlocProvider<InternetCubit>(
            create: (_) =>
              InternetCubit(connectivity: connectivity),
          ),
          BlocProvider<WeatherCubit>(
            create: (weatherCubitContext) =>
              WeatherCubit(weatherCubitContext.read<WeatherRepositoryImpl>()),
          ),
          BlocProvider<AdviceCubit>(
            create: (adviceCubitContext) =>
              AdviceCubit(
                adviceRepository: adviceCubitContext.read<AdviceRepositoryImpl>()
              ),
          ),
        ],
        child: const _AppView(),
      ),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: WeatherTheme.light,
      darkTheme: WeatherTheme.dark,
      themeMode: ThemeMode.system,
      home: WeatherPage(),
    );
  }
}




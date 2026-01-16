import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/location/default_address_tracker.dart';
import 'package:weather_app/data/location/location_repository_impl.dart';
import 'package:weather_app/data/remote/clarifai_api.dart';
import 'package:weather_app/data/remote/open_meteo_api.dart';
import 'package:weather_app/data/repository/advice_repository_impl.dart';
import 'package:weather_app/data/repository/weather_repository_impl.dart';
import 'package:weather_app/domain/location/address_tracker.dart';
import 'package:weather_app/domain/location/location_repository.dart';
import 'package:weather_app/domain/remote/ai_api_client.dart';
import 'package:weather_app/domain/remote/weather_api_client.dart';
import 'package:weather_app/domain/repository/advice_repository.dart';
import 'package:weather_app/domain/repository/weather_repository.dart';
import 'package:weather_app/presentation/cubit/address_tracker/address_tracker_cubit.dart';
import 'package:weather_app/presentation/cubit/ai_advice/advice_cubit.dart';
import 'package:weather_app/presentation/cubit/internet_connection/internet_cubit.dart';
import 'package:weather_app/presentation/cubit/location/location_cubit.dart';
import 'package:weather_app/presentation/cubit/weather/weather_cubit.dart';
import 'package:weather_app/presentation/pages/weather_page.dart';
import 'package:weather_app/presentation/theme/weather_theme.dart';

class App extends StatelessWidget {
  final Connectivity connectivity;

  const App({required this.connectivity, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WeatherApiClient>(
          create: (_) => OpenMeteoApiClient(),
          dispose: (apiClient) => apiClient.close(),
        ),
        RepositoryProvider<AIApiClient>(
          create: (_) => ClarifaiApiClient(),
          dispose: (apiClient) => apiClient.close(),
        ),
        RepositoryProvider<LocationRepository>(
          create: (_) => LocationRepositoryImpl(),
        ),
        RepositoryProvider<AddressTracker>(
          create: (_) => DefaultAddressTracker(),
        ),
        RepositoryProvider<WeatherRepository>(
          create: (context) => WeatherRepositoryImpl(
            apiClient: context.read<WeatherApiClient>(),
          ),
          dispose: (repository) => repository.dispose(),
        ),
        RepositoryProvider<AdviceRepository>(
          create: (context) =>
              AdviceRepositoryImpl(apiClient: context.read<AIApiClient>()),
          dispose: (repository) => repository.dispose(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LocationCubit>(
            create: (context) =>
                LocationCubit(context.read<LocationRepository>()),
          ),
          BlocProvider<AddressTrackerCubit>(
            create: (context) =>
                AddressTrackerCubit(context.read<AddressTracker>()),
          ),
          BlocProvider<InternetCubit>(
            create: (_) => InternetCubit(connectivity: connectivity),
          ),
          BlocProvider<WeatherCubit>(
            create: (context) =>
                WeatherCubit(context.read<WeatherRepository>()),
          ),
          BlocProvider<AdviceCubit>(
            create: (context) =>
                AdviceCubit(adviceRepository: context.read<AdviceRepository>()),
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

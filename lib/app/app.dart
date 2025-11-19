import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/location/default_address_tracker.dart';
import 'package:weather_app/data/location/location_repository_impl.dart';
import 'package:weather_app/data/repository/weather_repository_impl.dart';
import 'package:weather_app/presentation/cubit/address_tracker/address_tracker_cubit.dart';
import 'package:weather_app/presentation/cubit/location/location_cubit.dart';
import 'package:weather_app/presentation/cubit/weather/weather_cubit.dart';

import '/presentation/pages/weather_page.dart';
import '/presentation/theme/weather_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => WeatherRepositoryImpl(),
          dispose: (repository) => repository.dispose(),
        ),
        RepositoryProvider(
          create: (context) => LocationRepositoryImpl(),
        ),
        RepositoryProvider(
          create: (context) => DefaultAddressTracker(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LocationCubit>(
            create: (context) =>
                LocationCubit(context.read<LocationRepositoryImpl>())..getPosition(),
          ),
          BlocProvider<AddressTrackerCubit>(
              create: (context) => 
                AddressTrackerCubit(context.read<DefaultAddressTracker>()),
          ),
          BlocProvider<WeatherCubit>(
            create: (context) =>
                WeatherCubit(context.read<WeatherRepositoryImpl>()),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
      themeMode: ThemeMode.light,
      theme: WeatherTheme.light,
      darkTheme: WeatherTheme.dark,
    );
  }
}




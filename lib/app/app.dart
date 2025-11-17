import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/location/location_repository_impl.dart';
import 'package:weather_app/data/repository/weather_repository_impl.dart';
import 'package:weather_app/presentation/cubit/location/location_cubit.dart';
import 'package:weather_app/presentation/cubit/weather/weather_cubit.dart';

import '../presentation/pages/weather_page.dart';

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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LocationCubit>(
            create: (context) =>
                LocationCubit(context.read<LocationRepositoryImpl>())..getPosition(),
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
    );
  }
}




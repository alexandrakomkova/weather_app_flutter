import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repository/weather_repository_impl.dart';
import 'package:weather_app/presentation/cubit/weather_cubit.dart';

import '../presentation/pages/weather_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (_) => WeatherRepositoryImpl(),
      dispose: (repository) => repository.dispose(),
      child: BlocProvider(
          create: (context) => WeatherCubit(context.read<WeatherRepositoryImpl>()),
        child: const AppView(),
      )
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage()
    );
  }
}


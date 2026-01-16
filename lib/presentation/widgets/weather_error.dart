import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/cubit/weather/weather_cubit.dart';

class WeatherError extends StatelessWidget {
  const WeatherError({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            return Text(
              'Something went wrong! Please, try later. Unexpected error: ${state.errorMessage}',
              style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.colorScheme.primary,
              ),
            );
          },
        ),
        const SizedBox(height: 15.0),
        OutlinedButton(
          onPressed: () {
            context.read<WeatherCubit>().refreshWeather();
          },
          child: Text('Try again', style: theme.textTheme.bodyLarge),
        ),
      ],
    );
  }
}

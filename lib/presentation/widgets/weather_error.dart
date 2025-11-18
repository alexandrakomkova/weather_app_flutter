import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/weather/weather_cubit.dart';

class WeatherError extends StatelessWidget {
  const WeatherError({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(30, 1.5 * kToolbarHeight, 30, 20),
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'Something went wrong! Please, try later.',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300
                  ),
                ),
                SizedBox(height: 10.0,),
                OutlinedButton(
                    onPressed: () {
                      context.read<WeatherCubit>().refreshWeather();
                    },
                    child: Text(
                        'Try again',
                    ),
                )
              ],
            )
        )
    );
  }
}

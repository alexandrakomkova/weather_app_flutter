import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WeatherTheme {
  static ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: Colors.blue,
        surface: Colors.white
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: Colors.blue,
        surface: Colors.black
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark
      ),
    ),
  );
}
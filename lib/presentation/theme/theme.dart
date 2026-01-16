import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: Colors.blue,
      surface: Colors.white,
    ),
    snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
    ),
    textTheme: TextTheme(
      labelMedium: TextStyle(fontSize: 16),
      headlineLarge: TextStyle(fontSize: 50, fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
      bodyLarge: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
      bodySmall: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
    ),
  );

  static ThemeData dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: Colors.blue,
      surface: Colors.black,
    ),
    snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
    ),
    textTheme: TextTheme(
      labelMedium: TextStyle(fontSize: 16),
      headlineLarge: TextStyle(fontSize: 50, fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
      bodyLarge: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
      bodySmall: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
    ),
  );
}

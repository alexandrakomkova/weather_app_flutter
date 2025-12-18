import 'package:flutter/material.dart';

enum WeatherCondition {
  clear(condition: 'clear', icon: 'assets/clear.png', thirdColor: Color(0xfffad9d5), secondColor: Color(0xffaef0ff), mainColor: Color(0xFF1cddda)),
  mainlyClear(condition: 'mainly clear', icon: 'assets/mainly_clear.png', thirdColor: Color(0xffa5d8ea), secondColor: Color(0xff176298), mainColor: Color(0xffa1b4ff)),
  rainy(condition: 'rainy', icon: 'assets/rainy.png', thirdColor: Color(0xff173f5f), secondColor: Color(0xFF20639B), mainColor: Color(0xFF3CAEA3)),
  rainShowers(condition: 'rain showers', icon: 'assets/rain_showers.png', thirdColor: Color(0xffbae4fd), secondColor: Color(0xFF0091b9), mainColor: Color(0xFF004e9b)),
  cloudy(condition: 'cloudy', icon: 'assets/cloudy.png', thirdColor: Color(0xff063647), secondColor: Color(0xff1772b5), mainColor: Color(0xff879cfa)),
  thunderstorm(condition: 'thunderstorm', icon: 'assets/thunderstorm.png', thirdColor: Color(0xFFFFAB40), secondColor: Color(0xFF673AB7), mainColor: Colors.deepPurple),
  drizzle(condition: 'drizzle', icon: 'assets/drizzle.png', thirdColor: Color(0xFF86a3c3), secondColor: Color(0xFF7268a6), mainColor: Color(0xff683074)),
  freezingDrizzle(condition: 'freezing drizzle', icon: 'assets/freezing_drizzle.png', thirdColor: Color(0xFFb6cec7), secondColor: Color(0xFF86a3c3), mainColor: Color(0xff7268a6)),
  snowy(condition: 'snowy', icon: 'assets/snowy.png', thirdColor: Color(0xFF97deff), secondColor: Color(0xFFc9eeff), mainColor: Color(0xff3e54ac)),
  unknown(condition: 'unknown', icon: 'assets/cloudy.png', thirdColor: Colors.blueGrey, secondColor: Colors.white70, mainColor: Colors.grey);

  final String icon;
  final String condition;
  final Color thirdColor;
  final Color secondColor;
  final Color mainColor;

  const WeatherCondition({
    required this.icon,
    required this.condition,
    required this.thirdColor,
    required this.secondColor,
    required this.mainColor,
  });
}
import 'package:flutter/material.dart';

LinearGradient getWeatherGradient(String condition) {
  switch (condition.toLowerCase()) {
    case 'clear':
    case 'sunny':
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFFF9800),
          Color(0xFFFFC107),
          Color(0xFFFFECB3),
        ],
      );

    case 'clouds':
    case 'partly cloudy':
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF5C6BC0),
          Color(0xFF90CAF9),
          Color(0xFFE3F2FD),
        ],
      );

    case 'rain':
    case 'drizzle':
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF1565C0),
          Color(0xFF42A5F5),
          Color(0xFFB3E5FC),
        ],
      );

    case 'thunderstorm':
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF283593),
          Color(0xFF5C6BC0),
          Color(0xFFC5CAE9),
        ],
      );

    case 'snow':
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFE1F5FE),
          Color(0xFFF5F9FF),
          Color(0xFFFFFFFF),
        ],
      );

    case 'mist':
    case 'fog':
    case 'haze':
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF90A4AE),
          Color(0xFFCFD8DC),
          Color(0xFFECEFF1),
        ],
      );

    case 'night':
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF0D1B2A),
          Color(0xFF1B263B),
          Color(0xFF415A77),
        ],
      );

    default:
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF42A5F5),
          Color(0xFF90CAF9),
          Color(0xFFE3F2FD),
        ],
      );
  }
}
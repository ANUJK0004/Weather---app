import 'package:mausam/models/weekly_forecast.dart';

import 'hourly_forecast.dart';

class Weather {
  final String city;
  final int temperature;
  final int windSpeed;
  final int humidity;
  final int feelsLike;
  final int uv;
  final String condition;
  final String icon;
  final String sunrise;
  final String sunset;
  final List<HourlyForecast> hourlyForecast;
  final List<WeeklyForecast> weeklyForecast;


  // final int aqi;

  Weather({
    required this.city,
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    required this.feelsLike,
    required this.uv,
    required this.condition,
    required this.icon,
    required this.hourlyForecast,
    required this.weeklyForecast,
    required this.sunrise,
    required this.sunset,
  });

  Weather.fromJson(Map<String, dynamic> json)
    : city = json['location']['name'],
      temperature = json['current']['temp_c'].toInt(),
      windSpeed = json['current']['wind_kph'].toInt(),
      humidity = json['current']['humidity'].toInt(),
      feelsLike = json['current']['feelslike_c'].toInt(),
      uv = json['current']['uv'].toInt(),
      condition = json['current']['condition']['text'],
      icon = json['current']['condition']['icon'],
      sunrise = json['forecast']['forecastday'][0]['astro']['sunrise'],
      sunset = json['forecast']['forecastday'][0]['astro']['sunset'],
      hourlyForecast = (json['forecast']['forecastday'][0]['hour'] as List).map((item) => HourlyForecast.fromJson(item)).toList(),
      weeklyForecast = (json['forecast']['forecastday'] as List).map((item) => WeeklyForecast.fromJson(item)).toList();
}

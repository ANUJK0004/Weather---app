import 'dart:convert';

import 'package:http/http.dart' as http;

String key = "eb6f3a2c86b849c3880174258262606";
Future<WeatherUpdates> fetchWeather() async {
  final response = await http.get(Uri.parse("https://api.weatherapi.com/v1/current.json?$key&q=Agra"),
    headers: {'Accept': 'application/json'},
  );
  if(response.statusCode == 200){
    print(response.body);
    return WeatherUpdates.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to load weather data');

  }
}

class WeatherUpdates {
  late String city;
  late int temperature;
  late int windSpeed;
  late int humidity;
  late int aqi;

  WeatherUpdates({required this.city});

  WeatherUpdates.fromJson(Map<String, dynamic> json){
    city = json['location']['name'];
    temperature = json['current']['temp_c'];
    windSpeed = json['current']['wind_kph'];
    humidity = json['current']['humidity'];
    aqi = json['current']['air_quality']['pm2_5'];
  }
}
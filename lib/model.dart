import 'dart:convert';

import 'package:http/http.dart' as http;

import 'home_screen.dart';

String key = "eb6f3a2c86b849c3880174258262606";
Future<Weather> fetchWeather(String city) async {
  final response = await http.get(Uri.parse("https://api.weatherapi.com/v1/current.json?key=$key&q=Agra"),
    headers: {'Accept': 'application/json'},
  );
  if(response.statusCode == 200){
    return Weather.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }else{
    throw Exception('Failed to load weather data');

  }
}


import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

String key = "eb6f3a2c86b849c3880174258262606";
Future<Weather> fetchWeather(String query) async {

  final response = await http.get(Uri.parse("https://api.weatherapi.com/v1/forecast.json?key=$key&q=$query&days=7&aqi=no&alerts=no"),
    headers: {'Accept': 'application/json'},
  );
  if(response.statusCode == 200){
    return Weather.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }else{
    throw Exception('Failed to load weather data');

  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/model.dart';

String key = "eb6f3a2c86b849c3880174258262606";
Future<Weather> fetchWeather(String lat,String lon) async {

  final response = await http.get(Uri.parse("https://api.weatherapi.com/v1/current.json?key=$key&q=$lat,$lon"),
    headers: {'Accept': 'application/json'},
  );
  if(response.statusCode == 200){
    print(response.body);
    return Weather.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }else{
    throw Exception('Failed to load weather data');

  }
}
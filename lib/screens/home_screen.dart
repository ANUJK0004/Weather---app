import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mausam/Widgets/weather_body.dart';
import 'package:mausam/screens/error_screen.dart';
import 'package:mausam/screens/loading_screen.dart';
import 'package:mausam/utils/theme.dart';
import 'package:mausam/utils/weather_background.dart';
import '../models/weather.dart';
import '../services/location_service.dart';
import '../services/weather_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Weather>? weatherUpdates;


  Future<void> fetchLocation() async {
    Position position = await determinePosition();
    setState(() {
      weatherUpdates = fetchWeather(
        "${position.latitude.toString()},${position.longitude.toString()}",
      );
    });
  }

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder<Weather>(
        future: weatherUpdates,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          }
          if (snapshot.hasError) {
            return ErrorScreen(
              onRetry: (){
                setState((){
                  weatherUpdates = fetchLocation() as Future<Weather>?;
                });
              },
            );
          }
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          final weather = snapshot.data!;
          final gradient = getWeatherGradient(weather.condition);
          return RefreshIndicator(
            onRefresh: fetchLocation,
            color: fontColor,
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                gradient: gradient,
              ),
              child: WeatherBody(
                weather: weather,
                onCitySelected: (city) {
                  setState(() {
                    weatherUpdates = fetchWeather(city);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

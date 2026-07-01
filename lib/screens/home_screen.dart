import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mausam/Widgets/weather_body.dart';
import 'package:mausam/utils/theme.dart';
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
      backgroundColor: primary,
      body: FutureBuilder<Weather>(
        future: weatherUpdates,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(
              color: fontColor,
              backgroundColor: primary,
            ));
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          final weather = snapshot.data!;
          return RefreshIndicator(
            onRefresh: fetchLocation,
            color: fontColor,
            backgroundColor: primary,
            child: WeatherBody(
              weather: weather,
              onCitySelected: (city) {
                setState(() {
                  weatherUpdates = fetchWeather(city);
                });
              },
            ),
          );
        },
      ),
    );
  }
}

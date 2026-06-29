import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:mausam/Widgets/box_decoration.dart';
import '../models/hourly_forecast.dart';
import '../models/weather.dart';
import '../services/location_service.dart';
import '../services/weather_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class CitySearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
        iconSize: 24,
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: Icon(Icons.arrow_back, size: 24),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Type a city name', style: TextStyle(fontSize: 24)),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return SizedBox();
  }

  CitySearchDelegate({required String hintText})
    : super(
        searchFieldLabel: hintText,
        enableSuggestions: false,
        autocorrect: true,
        keyboardType: TextInputType.text,
      );
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Weather>? weatherUpdates;
  List<HourlyForecast> hourlyForecast = [];

  Future<void> fetchLocation() async {
    Position position = await determinePosition();
    setState(() {
      weatherUpdates = fetchWeather(
        "${position.latitude.toString()},${position.longitude.toString()}",
      );
    });
  }

  String getDayLabel(String date) {
    final forecastDate = DateTime.parse(date);
    final today = DateTime.now();

    if (forecastDate.year == today.year &&
        forecastDate.month == today.month &&
        forecastDate.day == today.day) {
      return "Today";
    }

    final tomorrow = today.add(const Duration(days: 1));

    if (forecastDate.year == tomorrow.year &&
        forecastDate.month == tomorrow.month &&
        forecastDate.day == tomorrow.day) {
      return "Tomorrow";
    }

    return DateFormat.EEEE().format(forecastDate);
  }

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: FutureBuilder<Weather>(
        future: weatherUpdates,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
            color: Colors.blue.shade900,
            backgroundColor: Colors.blue.shade100,
            child: CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: <Widget>[
                SliverAppBar(
                  title: Text(
                    snapshot.data!.city,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () async{
                        final city = await showSearch(
                          context: context,
                          delegate: CitySearchDelegate(hintText: 'Search weather by city'),
                        );
                        setState((){
                          if (city != null && city.isNotEmpty) {
                            weatherUpdates = fetchWeather(city);
                          }
                        });
                      },
                      icon: Icon(Icons.search, size: 36),
                      color: Colors.blue.shade900,
                      padding: EdgeInsets.only(right: 8),
                    ),
                  ],
                  shadowColor: Colors.blue.shade100,
                  expandedHeight: 300,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${snapshot.data!.temperature}°C',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 56,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                snapshot.data!.condition,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Image.network(
                            'https:${weather.icon}',
                            width: 100,
                            height: 100,
                          )
                        ],
                      ),
                    ),
                  ),
                  backgroundColor: Colors.blue.shade100,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(8),
                          decoration: decoration,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Weekly forecast',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade900,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: weather.weeklyForecast.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    final weeklyForecast = weather.weeklyForecast[index];
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                getDayLabel(weeklyForecast.date),
                                                style: TextStyle(
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue.shade900,
                                                ),
                                              ),
                                            ),
                                            Image.network(
                                              'https:${weeklyForecast.icon}',
                                              width: 64,
                                              height: 64,
                                            ),
                                            SizedBox(width: 12),
                                            Text(
                                              '${weeklyForecast.minTemperature}°C',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue.shade900,
                                              ),
                                            ),
                                            SizedBox(width: 16),
                                            Text(
                                              '${weeklyForecast.maxTemperature}°C',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue.shade900,
                                              ),
                                            ),
                                          ],
                                        ),
                                        index == 6 ? SizedBox() :
                                        Divider(
                                          color: Colors.blue.shade900,
                                          thickness: 2,
                                        ),
                                      ],
                                    );
                                  }
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          height: 240,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(8),
                          decoration: decoration,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Today',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade900,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: weather.hourlyForecast.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context,index){
                                    final hourlyForecast = weather.hourlyForecast[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            '${hourlyForecast.temperature}℃',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue.shade900,
                                            ),
                                          ),
                                          Image.network(
                                            'https:${hourlyForecast.icon}',
                                            width: 64,
                                            height: 64,
                                          ),
                                          Text(
                                            DateFormat.jm().format(DateTime.parse(hourlyForecast.time)),
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue.shade900,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                height: 150,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(12),
                                decoration: decoration,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${weather.windSpeed}km/h',
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue.shade900,
                                      ),
                                    ),
                                    Text(
                                      '💨Wind speed',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.blue.shade900,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                height: 150,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(12),
                                decoration: decoration,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${weather.feelsLike}℃',
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue.shade900,
                                      ),
                                    ),
                                    Text(
                                      'Real feel',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.blue.shade900,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                height: 150,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(12),
                                decoration: decoration,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${weather.uv}',
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                        color: weather.uv < 3 ? Colors.green : Colors.red.shade800,
                                      ),
                                    ),
                                    Text(
                                      'UV',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.blue.shade900
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                height: 150,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(12),
                                decoration: decoration,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${weather.humidity}%',
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue.shade900,
                                      ),
                                    ),
                                    Text(
                                      '💧Humidity',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.blue.shade900,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}




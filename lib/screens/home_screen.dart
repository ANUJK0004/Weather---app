import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mausam/Widgets/box_decoration.dart';
import '../models/model.dart';
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

  Future<void> fetchLocation() async {
    Position position = await determinePosition();
    setState(() {
      weatherUpdates = fetchWeather(
        position.latitude.toString(),
        position.longitude.toString(),
      );
    });
  }

  @override
  void initState() {
    fetchLocation();
    super.initState();
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
                      fontSize: 28,
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
                            weatherUpdates = fetchWeatherByCity(city);
                          }
                        });
                      },
                      icon: Icon(Icons.search, size: 36),
                      color: Colors.blue.shade900,
                      padding: EdgeInsets.only(right: 8),
                    ),
                  ],
                  shadowColor: Colors.blue.shade100,
                  expandedHeight: 200,
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
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(16),
                          decoration: decoration,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${weather.temperature}°C',
                                style: TextStyle(
                                  fontSize: 64,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                              Text(
                                snapshot.data!.city,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                              Text(
                                'Feels like : ${weather.feelsLike}°C',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(16),
                          decoration: decoration,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${weather.temperature}°C',
                                style: TextStyle(
                                  fontSize: 64,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                              Text(
                                weather.city,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                              Text(
                                'Feels like : ${weather.feelsLike}°C',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900,
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
                                padding: EdgeInsets.all(16),
                                decoration: decoration,
                                child: Text(
                                  '${weather.windSpeed}km/h',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                height: 150,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(16),
                                decoration: decoration,
                                child: Text(
                                  '${weather.humidity}%',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                                padding: EdgeInsets.all(16),
                                decoration: decoration,
                                child: Text(
                                  '${weather.uv}',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                height: 150,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(16),
                                decoration: decoration,
                                child: Text(
                                  '${weather.humidity}%',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                  ),
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

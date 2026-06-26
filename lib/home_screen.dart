import 'package:flutter/material.dart';

import 'model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var city = "Agra";
  var temperature = "35 ℃";
  var windSpeed  = "12 km/h";
  var humidity = "30%";
  var aqi = 100;

  late Future<WeatherUpdates> weatherUpdates;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD8FDFF),
      appBar: AppBar(
        title: Text('Mausam',style: TextStyle(color: Colors.white, fontSize: 36,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue.shade800,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(8),
        children: <Widget>[
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(colors: [Colors.blue.shade50,Colors.blue.shade400],begin: Alignment.bottomLeft,end: Alignment.topRight),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  temperature,
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                Text(
                  city,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 80,
            margin: EdgeInsets.symmetric(vertical: 12),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(colors: [Colors.blue.shade50,Colors.blue.shade400],begin: Alignment.bottomLeft,end: Alignment.topRight),
            ),
            child: Text(
              "AQI : $aqi",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
              Expanded(
                child: Container(
                  height: 150,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(colors: [Colors.blue.shade50,Colors.blue.shade400],begin: Alignment.bottomLeft,end: Alignment.topRight),
                  ),
                  child: Text(
                    windSpeed,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Container(
                  height: 150,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(colors: [Colors.blue.shade50,Colors.blue.shade400],begin: Alignment.bottomLeft,end: Alignment.topRight),
                  ),
                  child: Text(
                    humidity,
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
    );
  }
}

import 'package:flutter/material.dart';

import 'model.dart';

class Weather {
  final String city;
  final int temperature;
  final int windSpeed;
  final int humidity;
  // final int aqi;

  Weather({required this.city, required this.temperature, required this.windSpeed, required this.humidity});

  Weather.fromJson(Map<String, dynamic> json) :
        city = json['location']['name'],
        temperature = json['current']['temp_c'].toInt(),
        windSpeed = json['current']['wind_kph'].toInt(),
        humidity = json['current']['humidity'].toInt();

}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Weather> weatherUpdates;

  @override
  void initState() {
    super.initState();
    weatherUpdates = fetchWeather("Agra");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD8FDFF),
      appBar: AppBar(
        title: Text('Mausam',style: TextStyle(color: Colors.white, fontSize: 36,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue.shade800,
      ),
      body: FutureBuilder<Weather>(
          future: weatherUpdates, builder: (context, snapshot){
            if(snapshot.hasData){
              return ListView(
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
                          '${snapshot.data!.temperature}°C',
                          style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        Text(
                          snapshot.data!.city,
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
                      "AQI : 100",
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
                            '${snapshot.data!.windSpeed}km/h',
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
                            '${snapshot.data!.humidity}%',
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
              );
            }
            else if(snapshot.hasError){
              return Text('${snapshot.error}');
            }
            else{
              return CircularProgressIndicator();
            }
          }
      )
    );
  }
}

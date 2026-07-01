import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mausam/utils/box_decoration.dart';
import 'package:mausam/models/hourly_forecast.dart';
import 'package:mausam/utils/theme.dart';

class HourlyForecastWidget extends StatelessWidget {
  const HourlyForecastWidget({super.key,required this.hourlyForecast});
  final List<HourlyForecast> hourlyForecast;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
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
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: fontColor,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: hourlyForecast.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  final hourlyForecast = this.hourlyForecast[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          '${hourlyForecast.temperature}℃',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: fontColor,
                          ),
                        ),
                        Image.network(
                          'https:${hourlyForecast.icon}',
                          width: 64,
                          height: 64,
                        ),
                        Text(
                          DateFormat.j().format(DateTime.parse(hourlyForecast.time)),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: fontColor,
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
    );
  }
}

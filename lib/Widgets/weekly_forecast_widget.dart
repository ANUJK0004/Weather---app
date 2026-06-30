import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mausam/models/weekly_forecast.dart';

import 'box_decoration.dart';

class WeeklyForecastWidget extends StatelessWidget {
  const WeeklyForecastWidget({super.key,required this.weeklyForecast});
  final List<WeeklyForecast> weeklyForecast;

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
  Widget build(BuildContext context) {
    return Container(
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
                itemCount: weeklyForecast.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final weeklyForecast = this.weeklyForecast[index];
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
    );
  }
}

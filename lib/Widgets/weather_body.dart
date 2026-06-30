import 'package:flutter/material.dart';
import 'package:mausam/Widgets/hourly_forecast_widget.dart';
import 'package:mausam/Widgets/sliver_app_bar.dart';
import 'package:mausam/Widgets/weekly_forecast_widget.dart';
import 'package:mausam/Widgets/widget_info_grid.dart';
import 'package:mausam/models/weather.dart';

class WeatherBody extends StatelessWidget {
  const WeatherBody({
    super.key,
    required this.weather,
    required this.onCitySelected,
  });
  final Weather weather;
  final ValueChanged<String> onCitySelected;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        MausamSliverAppBar(
          cityName: weather.city,
          temperature: weather.temperature,
          condition: weather.condition,
          icon: weather.icon,
          onCitySelected: (city) {
            onCitySelected(city);
          },
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                WeeklyForecastWidget(weeklyForecast: weather.weeklyForecast),
                const SizedBox(height: 12),
                HourlyForecastWidget(hourlyForecast: weather.hourlyForecast),
                WidgetInfoGrid(weather: weather),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

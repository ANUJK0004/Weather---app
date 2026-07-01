import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mausam/Widgets/hourly_forecast_widget.dart';
import 'package:mausam/Widgets/last_updated.dart';
import 'package:mausam/Widgets/sliver_app_bar.dart';
import 'package:mausam/Widgets/sunrise_sunset_card.dart';
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
      physics: const BouncingScrollPhysics(),
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                LastUpdated(time: DateFormat.jm().format(DateTime.now())),
                HourlyForecastWidget(hourlyForecast: weather.hourlyForecast),
                WidgetInfoGrid(weather: weather),
                const SizedBox(height: 20),
                SunriseSunsetCard(sunrise: weather.sunrise, sunset: weather.sunset,),
                const SizedBox(height: 20),
                WeeklyForecastWidget(weeklyForecast: weather.weeklyForecast),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mausam/Widgets/weather_info_card.dart';
import 'package:mausam/models/weather.dart';

class WidgetInfoGrid extends StatelessWidget {
  const WidgetInfoGrid({super.key, required this.weather});
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        WeatherInfoCard(
          info: "${weather.windSpeed}km/h",
          title: '💨Wind speed',
        ),
        WeatherInfoCard(info: "${weather.feelsLike}℃", title: '💭Real feel'),
        WeatherInfoCard(
          info: "${weather.uv}",
          title: '🔆UV',
          color: weather.uv < 3 ? Colors.green : Colors.red.shade800,
        ),
        WeatherInfoCard(info: "${weather.humidity}%", title: '💧Humidity'),
      ],
    );
  }
}

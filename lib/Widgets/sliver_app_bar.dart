import 'package:flutter/material.dart';
import 'package:mausam/utils/theme.dart';
import '../models/city_search_delegate.dart';

class MausamSliverAppBar extends StatelessWidget {
  const MausamSliverAppBar({
    super.key,
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.onCitySelected,
  });

  final String cityName;
  final int temperature;
  final String condition;
  final String icon;
  final ValueChanged<String> onCitySelected;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(
        cityName,
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: fontColor,
        ),
        textAlign: TextAlign.left,
      ),
      actions: [
        IconButton(
          onPressed: () async {
            final city = await showSearch(
              context: context,
              delegate: CitySearchDelegate(hintText: 'Search weather by city'),
            );
            if (city != null && city.isNotEmpty) {
              onCitySelected(city);
            }
          },
          icon: Icon(Icons.search, size: 36),
          color: fontColor,
          padding: EdgeInsets.only(right: 8),
        ),
      ],
      shadowColor: primary,
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
                    '$temperature°C',
                    style: TextStyle(
                      color: currentDataFontColor,
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    condition,
                    style: TextStyle(
                      color: currentDataFontColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Image.network('https:$icon', width: 100, height: 100),
            ],
          ),
        ),
      ),
      backgroundColor: primary,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mausam/utils/theme.dart';

import 'box_decoration.dart';

class WeatherInfoCard extends StatelessWidget {
  const WeatherInfoCard({super.key, required this.info,required this.title,this.color});
  final String info;
  final String title;
  final Color? color;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            info,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: color ?? fontColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              color: fontColor,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

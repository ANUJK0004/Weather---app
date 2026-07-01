import 'package:flutter/material.dart';
import 'package:mausam/utils/box_decoration.dart';

class SunriseSunsetCard extends StatelessWidget {
  final String sunrise;
  final String sunset;

  const SunriseSunsetCard({
    super.key,
    required this.sunrise,
    required this.sunset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: decoration,
      child: Column(
        children: [
          const Text(
            "Sunrise & Sunset",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 18),

          const Divider(),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Icon(
                      Icons.wb_sunny_outlined,
                      color: Colors.orange,
                      size: 40,
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Sunrise",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      sunrise,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Container(height: 80, width: 1, color: Colors.white54),

              Expanded(
                child: Column(
                  children: [
                    const Icon(
                      Icons.wb_twilight,
                      color: Colors.deepOrange,
                      size: 40,
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Sunset",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      sunset,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

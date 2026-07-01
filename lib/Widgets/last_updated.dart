import 'package:flutter/material.dart';
import 'package:mausam/utils/box_decoration.dart';

class LastUpdated extends StatelessWidget {
  final String time;

  const LastUpdated({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 18),
      child: Container(
        decoration : decoration,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.access_time_rounded, size: 18),

              const SizedBox(width: 6),

              Text(
                "Updated • $time",
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

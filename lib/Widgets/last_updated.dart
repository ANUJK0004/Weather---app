import 'package:flutter/material.dart';

class LastUpdated extends StatelessWidget {
  final String time;

  const LastUpdated({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.access_time_rounded, size: 18),

          const SizedBox(width: 6),

          Text(
            "Updated • $time",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

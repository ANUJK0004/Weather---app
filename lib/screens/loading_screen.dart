import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF64B5F6),
            Color(0xFF90CAF9),
            Color(0xFFE3F2FD),
          ],
        )
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            TweenAnimationBuilder(
              tween: Tween(begin: 0.9, end: 1.1),
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Transform.scale(scale: value, child: child);
              },
              onEnd: () {},
              child: const Icon(Icons.wb_sunny, size: 70, color: Colors.orange),
            ),

            const Text(
              "Fetching weather...",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text("Please wait", style: TextStyle(color: Colors.grey)),
            const SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
          ],
        ),
      ),
    );
  }
}

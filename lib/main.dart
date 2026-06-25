import 'package:flutter/material.dart';

import 'home_screen.dart';

void main(){
  runApp(Mausam());
}

class Mausam extends StatefulWidget {
  const Mausam({super.key});

  @override
  State<Mausam> createState() => _MausamState();
}

class _MausamState extends State<Mausam> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mausam',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}



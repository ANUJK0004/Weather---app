import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration decoration = BoxDecoration(
  borderRadius: BorderRadius.circular(16),
  gradient: LinearGradient(
    colors: [Colors.blue.shade50, Colors.blue.shade300],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  ),
);

import 'package:flutter/material.dart';

BoxDecoration decoration = BoxDecoration(
  borderRadius: BorderRadius.circular(16),
  color: Colors.white.withOpacity(0.18),
  border: Border.all(
    color: Colors.white.withOpacity(0.25),
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 12,
      offset: Offset(0, 6),
    ),
  ],
);

import 'package:flutter/material.dart';

BoxDecoration setMainBgGradient() {
  return const BoxDecoration(
    gradient: LinearGradient(
      colors: [Color.fromARGB(255, 184, 215, 229), Color.fromARGB(255, 186, 232, 215)],
      stops: [0, 1],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
}

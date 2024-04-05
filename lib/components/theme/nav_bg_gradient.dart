import 'package:flutter/material.dart';

BoxDecoration setNavBgGradient() {
  return const BoxDecoration(
    gradient: LinearGradient(
      colors: [Color.fromARGB(255, 242, 195, 178), Color(0xFFE5A8B6)],
      stops: [0, 1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(30),
      topLeft: Radius.circular(30),
    ),
  );
}

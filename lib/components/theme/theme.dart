import 'package:flutter/material.dart';

ThemeData defaultMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Color.fromARGB(255, 186, 232, 215),
    primary: Colors.grey.shade300,
    secondary: Colors.grey.shade200,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade800,
    primary: Colors.grey.shade700,
    secondary: Colors.grey.shade600,
  ),
);

ThemeData saharaMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.yellow.shade200,
    primary: Colors.brown.shade300,
    secondary: Colors.brown.shade400,
  ),
);

ThemeData natureMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.green.shade200,
    primary: Colors.green.shade300,
    secondary: Colors.green.shade400,
  ),
);
import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: const Color.fromARGB(255, 15, 15, 15),
    primary: const Color.fromARGB(255, 169, 169, 169),
    secondary: const Color.fromARGB(255, 20, 20, 20),
    tertiary: const Color.fromARGB(255, 29, 29, 29),
    inversePrimary: const Color.fromARGB(255, 220, 220, 220),
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 15, 15, 15),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontSize: 14, color: Colors.white), // Giảm từ 16 xuống 14
    headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w500), // Giảm từ 20 xuống 18
  ),
);
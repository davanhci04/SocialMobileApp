import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: const Color.fromARGB(255, 33, 150, 243),
    secondary: const Color.fromARGB(255, 224, 224, 224),
    tertiary: const Color.fromARGB(255, 245, 245, 245),
    inversePrimary: const Color.fromARGB(255, 13, 71, 161),
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black87), // Giảm từ 16 xuống 14
    headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w500), // Giảm từ 20 xuống 18
  ),
);
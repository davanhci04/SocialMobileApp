import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.white, // Nền của các thành phần
    primary: Colors.blue.shade700, // Màu chính (cho icon, chữ)
    secondary: Colors.blue.shade300, // Màu phụ
    tertiary: Colors.blue.shade100, // Màu nhấn
    inversePrimary: Colors.blue.shade900, // Màu chữ nhấn mạnh
  ),
  scaffoldBackgroundColor: Colors.white, // Nền chính của toàn bộ app
);

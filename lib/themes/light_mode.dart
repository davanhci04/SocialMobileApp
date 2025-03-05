import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300, // Nền của các thành phần
    primary: Colors.grey.shade500, // Màu chính (cho icon, chữ)
    secondary: Colors.grey.shade200, // Màu phụ
    tertiary: Colors.grey.shade100, // Màu nhấn
    inversePrimary: Colors.grey.shade900, // Màu chữ nhấn mạnh
  ),
  scaffoldBackgroundColor: Colors.grey.shade300, // Nền chính của toàn bộ app
);

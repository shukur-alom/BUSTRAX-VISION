import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData lightThemeData = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(12),
        textStyle: const TextStyle(fontSize: 20, letterSpacing: 0.5),
      ),
    ),
  );
}

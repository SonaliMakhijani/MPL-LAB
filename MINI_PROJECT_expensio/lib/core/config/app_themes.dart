import 'package:flutter/material.dart';
import '/core/constants/styles.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: borderRadiusDefault),
        padding: const EdgeInsets.all(paddingDefault),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey),
    ),
  );

  static ThemeData lightTheme = ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: borderRadiusDefault),
        padding: const EdgeInsets.all(paddingDefault),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey),
    ),
  );
}

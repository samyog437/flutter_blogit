import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(150, 40),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 18,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          foregroundColor: Colors.black),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Color(0xFFad5389),
      elevation: 4,
    ),
  );
}

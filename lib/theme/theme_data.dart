import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primarySwatch: Colors.indigo,
    scaffoldBackgroundColor: Colors.grey,
    fontFamily: 'OpenSans Bold',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat Black'),
        backgroundColor: Colors.indigo,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 4,
      shadowColor: Colors.black,
      color: Color(0xFFad5389),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

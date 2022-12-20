import 'package:blogit/screen/loginscreen.dart';
import 'package:blogit/screen/splashscreen.dart';
import 'package:blogit/theme/theme_data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: getApplicationTheme(),
      routes: {
        '/': (context) => const SplashScreen(),
        '/loginScreen': (context) => const LoginScreen(),
      },
    ),
  );
}

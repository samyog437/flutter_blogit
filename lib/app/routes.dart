import 'package:blogit/app/theme_data.dart';
import 'package:blogit/screen/bottom_screen/addblogscreen.dart';
import 'package:blogit/screen/bottom_screen/dashboard.dart';
import 'package:blogit/screen/bottom_screen/homescreen.dart';
import 'package:blogit/screen/loginscreen.dart';
import 'package:blogit/screen/registerscreen.dart';
import 'package:blogit/screen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blogit',
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/loginScreen': (context) => const LoginScreen(),
        '/registerScreen': (context) => const RegisterScreen(),
      },
    );
  }
}

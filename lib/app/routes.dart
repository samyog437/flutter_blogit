import 'package:blogit/app/theme_data.dart';
import 'package:blogit/screen/blogdetail.dart';
import 'package:blogit/screen/bottom_screen/addblogscreen.dart';
import 'package:blogit/screen/bottom_screen/dashboard.dart';
import 'package:blogit/screen/bottom_screen/editBlogScreen.dart';
import 'package:blogit/screen/bottom_screen/homescreen.dart';
import 'package:blogit/screen/bottom_screen/profilescreen.dart';
import 'package:blogit/screen/bottom_screen/googleMap.dart';
import 'package:blogit/screen/loginscreen.dart';
import 'package:blogit/screen/registerscreen.dart';
import 'package:blogit/screen/splashscreen.dart';
import 'package:blogit/screen/wearos/wear_dashboard.dart';
import 'package:blogit/screen/wearos/wear_login.dart';
import 'package:blogit/screen/sensors/shake.dart';
import 'package:flutter/material.dart';

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
        // '/': (context) => const WearLoginScreen(),
        '/aboutScreen': (context) => const GoogleMapScreen(),
        WearDashboardScreen.route: (context) => const WearDashboardScreen(),
        EditBlogScreen.route: (context) => const EditBlogScreen(),
        '/loginScreen': (context) => const LoginScreen(),
        '/registerScreen': (context) => const RegisterScreen(),
        DashboardScreen.route: (context) => const DashboardScreen(),
        BlogDetailScreen.route: (context) => const BlogDetailScreen(),
        '/homeScreen': (context) => const HomeScreen(),
        '/addBlogScreen': (context) => const AddBlogScreen(),
        // '/profileScreen': (context) => const ProfileScreen(),
        ProfileScreen.route: (context) => const ProfileScreen(),
        '/shakeDetectorScreen': (context) => ShakeDetectorScreen(),
      },
    );
  }
}

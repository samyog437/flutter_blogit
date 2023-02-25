import 'package:blogit/objectbox.g.dart';
import 'package:blogit/repository/user_repository.dart';
import 'package:blogit/screen/bottom_screen/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String data = '';
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
    );
    super.initState();
    checkLoggedIn();
  }

  void checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final storedusername = prefs.getString('username');
    final storedpassword = prefs.getString('password');
    if (storedusername != null && storedpassword != null) {
      final isLogin =
          await UserRepositoryImpl().loginUser(storedusername, storedpassword);
      if (isLogin) {
        setState(() {
          Navigator.pushNamed(context, DashboardScreen.route,
              arguments: User_.userId);
        });
      }
    } else {
      setState(() {
        Navigator.pushReplacementNamed(context, '/loginScreen');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFad5389),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage('assets/images/logo.png'),
              width: 256,
              height: 256,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10,
            ),
            CircularProgressIndicator(
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'v1.0.0',
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

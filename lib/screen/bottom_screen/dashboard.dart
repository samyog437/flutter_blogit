import 'package:blogit/screen/bottom_screen/addblogscreen.dart';
import 'package:blogit/screen/bottom_screen/googleMap.dart';
import 'package:blogit/screen/bottom_screen/homescreen.dart';
import 'package:blogit/screen/bottom_screen/profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const String route = "dashboardScreen";

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  List<Widget> lstDasboardScreen = [
    const HomeScreen(),
    const AddBlogScreen(),
    const ProfileScreen(),
    const GoogleMapScreen(),
  ];

  _clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('dashboardPage'),
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                _clearSharedPreferences();
                Navigator.pushReplacementNamed(context, '/loginScreen');
              })
        ],
        automaticallyImplyLeading: false,
      ),
      body: lstDasboardScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline_outlined),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About Us',
          )
        ],
        backgroundColor: Color(0xFFad5389),
        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(
            () {
              _selectedIndex = index;
            },
          );
        },
      ),
    );
  }
}

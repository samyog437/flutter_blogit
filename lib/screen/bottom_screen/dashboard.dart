import 'package:blogit/screen/bottom_screen/addblogscreen.dart';
import 'package:blogit/screen/bottom_screen/homescreen.dart';
import 'package:blogit/screen/bottom_screen/profilescreen.dart';
import 'package:flutter/material.dart';

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
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
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

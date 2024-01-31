import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:heartbeats/Screens/Smart_Rate_Screen.dart';
import 'package:heartbeats/Screens/Sensor_Screen.dart';
import 'package:heartbeats/Screens/Settings_Screen.dart';
import 'package:heartbeats/constants/Constants.dart';


class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int _pageIndex = 0; 

  final List<Widget> _pages = [
    SensorScreen(), 
    SecondScreen(),    
    SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: _pages.elementAt(_pageIndex), 
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: primaryColor,
        animationDuration: const Duration(milliseconds: 300),
        onTap: _onItemTapped, // Update the selected index
        items: [
          SizedBox(
            height: 40,
            width: 40,
            child: Image.asset('assets/icons/heart-rate-monitor.png'),
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: Image.asset('assets/icons/heart.png'),
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: Image.asset('assets/icons/settings.png'),
          ),
        ],
      ),
    );
  }
}

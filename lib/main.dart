import 'package:flutter/material.dart';
import 'package:heartbeats/Screens/Sensor_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SensorScreen(),
    );
  }
}


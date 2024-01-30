import 'package:flutter/material.dart';
import 'package:heartbeats/constants/Constants.dart';

class SensorScreen extends StatefulWidget {
  const SensorScreen({super.key});

  @override
  State<SensorScreen> createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Sensor page", style: TextStyle(color: primaryColor, fontSize: 50)),
            ],
          ),
        ),
      ),
    );
  }
}
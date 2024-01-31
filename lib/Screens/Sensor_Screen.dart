import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heartbeats/constants/Constants.dart';

class SensorScreen extends StatefulWidget {
  const SensorScreen({super.key});

  @override
  State<SensorScreen> createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
  final List<FlSpot> bpmData = List.generate(
      60, (index) => FlSpot(index.toDouble(), (60 + (index % 20)).toDouble()));
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sensor",style: TextStyle(color: Colors.white,fontSize:40 ),)
      ],
    )
    )
    )
    );
  }
}

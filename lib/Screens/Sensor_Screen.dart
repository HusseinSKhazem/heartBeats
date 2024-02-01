

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:heartbeats/constants/Constants.dart';


class SensorScreen extends StatefulWidget {
  const SensorScreen({Key? key}) : super(key: key);

  @override
  _SensorScreenState createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
  List<FlSpot> bpmData = [];
  double nextIndex = 0;
  int? bpmValue;
  Timer? timer;

  static const int dataMaxLength = 60;
  static const double viewportWidth = 20;
  double maxY = 120;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      stopMeasurement();
    });
  }

  void stopMeasurement() {
    setState(() {
      timer?.cancel();
    });
  }

  void addBPMData(double value) {
    final point = FlSpot(nextIndex++, value);
    if (bpmData.length == dataMaxLength) {
      bpmData.removeAt(0);
      bpmData = bpmData.map((spot) => FlSpot(spot.x - 1, spot.y)).toList();
    }
    bpmData.add(point);
    updateMaxY(value);
  }

  void updateMaxY(double value) {
    if (value > maxY) {
      maxY = (value / 10).ceil() * 10; 
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildInstructionsCard(),
                const SizedBox(height: 30),
                buildHeartBPMCard(),
                const SizedBox(height: 30),
                buildBPMChartCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInstructionsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding:  EdgeInsets.all(20),
        child: Text(
          "Cover both the camera and flash with your finger",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

   Widget buildHeartBPMCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: (timer?.isActive ?? false)
            ? HeartBPMDialog(
                context: context,
                onRawData: (SensorValue value) {
                  addBPMData(value.value.toDouble());
                },
                onBPM: (int value) {
                  setState(() {
                    bpmValue = value;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.favorite, size: 48, color: Colors.redAccent),
                    const SizedBox(width: 10),
                    Text(
                      bpmValue?.toString() ?? "-",
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.redAccent),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : Container(

                alignment: Alignment.center,
                child: const Text(
                  "Measurement complete",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
      ),
    );
  }

Widget buildBPMChartCard() {
  return SizedBox(
    width: double.infinity,
    height: 200, 
    child: LineChart(
      LineChartData(
        minX: bpmData.isNotEmpty ? bpmData.first.x : 0, 
        maxX: bpmData.isNotEmpty ? bpmData.last.x : viewportWidth, 
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: bpmData,
            isCurved: true,
            color: Colors.redAccent,
            barWidth: 4, // Line thickness.
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    ),
  );
}
}

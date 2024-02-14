import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:heartbeats/Repository/Tone-Generator/ToneGenerator.dart';
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
  ToneGenerator toneGenerator = ToneGenerator();
  List<int> bpmReadings = [];
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
    if (bpmReadings.isNotEmpty) {
      final int averageBpm =
          bpmReadings.reduce((a, b) => a + b) ~/ bpmReadings.length;
      toneGenerator.playTone(averageBpm.toDouble());
      _showBpmAlertDialog(averageBpm);
    }
    bpmReadings.clear();
  }

  void _showBpmAlertDialog(int averageBpm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: _buildBpmDialogContent(averageBpm),
        );
      },
    );
  }

 Widget _buildBpmDialogContent(int averageBpm) {
  double screenWidth = MediaQuery.of(context).size.width;
  return Center(
    child: Container(
       width: screenWidth * 0.8,
      margin:const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.pinkAccent, Colors.redAccent],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 15,
            offset:  Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
           const SizedBox(height: 20),
            Image.asset( 
              'assets/icons/heart.png',
              height: 72,
            ),
           const SizedBox(height: 20),
           const Text(
              "Average BPM",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
           const SizedBox(height: 10),
           const Text(
              "Your average BPM is",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              averageBpm.toString(),
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.redAccent, backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child:const Text(
                "OK",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
           const SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
}


  // to draw the graph
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
    toneGenerator.stopTone();
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
        padding: EdgeInsets.all(20),
        child: Text(
          "Cover both the camera and flash with your finger",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54),
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
                    bpmReadings.add(value);
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.favorite,
                        size: 48, color: Colors.redAccent),
                    const SizedBox(width: 10),
                    Text(
                      bpmValue?.toString() ?? "-",
                      style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent),
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
              barWidth: 4,
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

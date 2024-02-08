import 'dart:async';
import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heartbeats/constants/Constants.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final List<FlSpot> bpmData = [];
  double time = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        final nextValue = 70 + 15 * math.sin(time * 2 * math.pi / 6);
        if (bpmData.length > 60) {
          bpmData.removeAt(0);
          bpmData.add(FlSpot(time, nextValue));
        } else {
          bpmData.add(FlSpot(time, nextValue));
        }
        time += 0.1;
      });
    });
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
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:  EdgeInsets.all(24.0),
                  child: Text("Heart Rate Monitor",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                ),
                Center(
  child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 32.0),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.white, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.pinkAccent.withOpacity(0.4),
            spreadRadius: 4,
            blurRadius: 10,
            offset:const  Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
        const  Icon(Icons.favorite, color: Colors.white, size: 30),
         const  SizedBox(width: 10),
          Text(
            "Current BPM: ${bpmData.isNotEmpty ? bpmData.last.y.toInt() : '--'}",
            style: TextStyle(
              color: Colors.pinkAccent,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(0, 1),
                  blurRadius: 3,
                  color: Colors.black.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: bpmData,
                              isCurved: true,
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.redAccent,
                                  Colors.pinkAccent,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              barWidth: 5,
                              isStrokeCapRound: true,
                              dotData:const  FlDotData(show: false),
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.red.withOpacity(0.3),
                                    Colors.pink.withOpacity(0.1),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
  child: AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.pinkAccent.withOpacity(0.4),
          spreadRadius: 2,
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
       const Icon(Icons.bluetooth_connected, color: Colors.pinkAccent, size: 20),
       const SizedBox(width: 10),
       const Text(
          "Sensor Status: Connected",
          style: TextStyle(
            color: Colors.pinkAccent,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 10,
          height: 10,
          decoration:const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.greenAccent,
          ),
        ),
      ],
    ),
  ),
),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

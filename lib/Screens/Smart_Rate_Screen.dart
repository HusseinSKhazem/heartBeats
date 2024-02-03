import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heartbeats/constants/Constants.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final List<FlSpot> bpmData = List.generate(
      60, (index) => FlSpot(index.toDouble(), (60 + (index % 20)).toDouble()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Heart Rate Monitor",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Text("Current BPM: 72",
                      style: TextStyle(
                          color: Colors.lightGreenAccent,
                          fontSize: 32,
                          fontWeight: FontWeight.bold)),
                ),
              ),
             Padding(
  padding: const EdgeInsets.all(16.0),
  child: Container(
    height: 200, 
    child: LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: bpmData,
            isCurved: true,
            color: Colors.redAccent,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    ),
  ),
),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildHeartRateZone("Resting", Colors.blue),
                    _buildHeartRateZone("Fat Burn", Colors.green),
                    _buildHeartRateZone("Cardio", Colors.orange),
                    _buildHeartRateZone("Peak", Colors.red),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text("Sensor Status: Connected",
                    style: TextStyle(
                        color: Colors.lightGreenAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeartRateZone(String zone, Color color) {
    return Column(
      children: [
        Icon(Icons.favorite, color: color),
        Text(zone, style:  const TextStyle(color: Colors.white)),
      ],
    );
  }
}

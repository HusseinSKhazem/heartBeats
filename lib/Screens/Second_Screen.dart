import 'package:flutter/material.dart';
import 'package:heartbeats/constants/Constants.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            Text("data",style: TextStyle(color: primaryColor),)
          ],
        ),
      )),
      ),
    );
  }
}
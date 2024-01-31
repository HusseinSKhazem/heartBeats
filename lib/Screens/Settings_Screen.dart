import 'package:flutter/material.dart';
import 'package:heartbeats/constants/Constants.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(child: Text("Settings Screen",style: TextStyle(color: Colors.white,fontSize: 40),))
            ],
          ),
        ) 
        )
        
    );
  }
}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:heartbeats/Repository/Provider/Token_Model.dart';
import 'package:heartbeats/Screens/Authentication/Login_Screen.dart';
import 'package:heartbeats/Screens/Navigation/ButtomNavigator.dart';
import 'package:heartbeats/constants/Constants.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();

   Future.delayed(const Duration(seconds: 5), () {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);

  if (authProvider.isAuthenticated) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const NavigatorScreen()));
  } else {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
  }
});}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _pulseAnimation.value,
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(text: 'Heart', style: TextStyle(color: Colors.black,fontSize: 58,fontWeight: FontWeight.bold)),
                    TextSpan(text: 'Sounds', style: TextStyle(color: primaryColor,fontSize:58,fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

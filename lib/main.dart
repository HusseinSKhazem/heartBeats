import 'dart:io';
import 'package:flutter/material.dart';
import 'package:heartbeats/Repository/Provider/Login_Model.dart';
import 'package:heartbeats/Repository/Provider/ProfilePicture_Model.dart';
import 'package:heartbeats/Repository/Provider/Token_Model.dart';
import 'package:heartbeats/Screens/Authentication/Login_Screen.dart';
import 'package:heartbeats/Screens/Navigation/ButtomNavigator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
void main() {
    runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => LoginModel()),
        ChangeNotifierProvider(create: (context) => UserProfileProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: authProvider.isAuthenticated ? const NavigatorScreen() : const LoginScreen(),
    );
  }
}

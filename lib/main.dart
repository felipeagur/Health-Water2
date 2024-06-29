import 'package:flutter/material.dart';
import 'package:health_water/screens/home/home_android.dart';
import 'screens/home/splash_screen.dart';
import 'screens/login_page.dart';
void main() {
  runApp(HealthWaterApp());
}

class HealthWaterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Water',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomeAndroid(),
      },
    );
  }
}


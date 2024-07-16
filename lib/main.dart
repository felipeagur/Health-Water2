import 'package:flutter/material.dart';
import 'package:health_water/screens/home/home_android.dart';
import 'package:health_water/screens/home/splash_screen.dart';
import 'package:health_water/screens/login_page.dart';
import 'package:health_water/screens/home/edit_screen.dart'; // Importe a tela de edição

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
        '/edit': (context) => EditScreen(), // Adicione a rota para a tela de edição
      },
    );
  }
}


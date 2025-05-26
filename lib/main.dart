import 'package:app_salud_citas/vistas/login_screen.dart';
import 'package:app_salud_citas/vistas/NewLoginScreen.dart';
import 'package:app_salud_citas/vistas/splah_screed.dart';
import 'package:flutter/material.dart';
import 'vistas/home_screen.dart';
import 'vistas/login_screen.dart';// <--- Aquí la importación

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menu Principal',
      home: const NewLoginScreen(),
      //home: const HomeScreen(),
    );
  }
}

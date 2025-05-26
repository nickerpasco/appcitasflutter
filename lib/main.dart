 
import 'package:flutter/material.dart';
import 'vistas/home_screen.dart'; // <--- Aquí la importación

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
      home: const HomeScreen(),
    );
  }
}

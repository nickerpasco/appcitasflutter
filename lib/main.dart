import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_salud_citas/vistas/NewLoginScreen.dart';
import 'package:app_salud_citas/providers/login_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menu Principal',
      home: const NewLoginScreen(),
    );
  }
}

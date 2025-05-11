import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6EE4B1), // 0%
              Color(0xFF69DAA9), // 10%
              Color(0xFF62CC9E), // 24%
              Color(0xFF489775), // 76%
              Color(0xFF3D7E62), // 100%
            ],
            stops: [0.0, 0.1, 0.24, 0.76, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Círculo superior izquierdo
            Positioned(
              top: -60,
              left: -265,
              child: Image.asset(
                'assets/circle_top_sf.png',
                width: 690,
                height: 290,
              ),
            ),

            // Círculo inferior derecho
            Positioned(
              bottom: -60,
              right: -60,
              child: Image.asset(
                'assets/circle_bottom_sf.png',
                width: 220,
                height: 420,
              ),
            ),

            // Label blanco centrado
            const Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Text(
                'Citas en Línea',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),


              // Label blanco centrado
            const Positioned(
              top: 150,
              left: 0,
              right: 0,
              child: Text(
                '¡La unica aplicacion que te brinda las mejores clinicas y especialistas del pais en un solo lugar!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Doctor en primer plano
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                'assets/doctor.png',
                width: 260,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

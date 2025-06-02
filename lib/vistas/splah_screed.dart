import 'package:app_salud_citas/vistas/NewLoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});


  @override
  State<SplashScreen> createState() => _SplashScreen();
}
class _SplashScreen extends State<SplashScreen>
with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 3),() {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder:(_) => const NewLoginScreen(),
      ),
      );

    });
  }

  @override
  void dispose(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
    super.dispose();
  }


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

            // Subtítulo centrado
            const Positioned(
              top: 150,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '¡La única aplicación que te brinda las mejores clínicas y especialistas del país en un solo lugar!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
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

            // Botón "Continuar"
            Positioned(
              bottom: 40,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                 Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewLoginScreen()),
              );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF3D7E62),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Continuar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

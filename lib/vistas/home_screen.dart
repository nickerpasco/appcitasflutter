import 'package:app_salud_citas/vistas/menu_screen.dart';
import 'package:app_salud_citas/vistas/splah_screed.dart';
import 'package:app_salud_citas/vistas/menu_screen.dart';
import 'package:app_salud_citas/vistas/selection_user_screen.dart';
import 'package:app_salud_citas/vistas/PacienteDetalleScreen.dart';
import 'package:app_salud_citas/vistas/RecetasScreen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';   // Asegúrate de importar tu LoginScreen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¡Hola, Flutter!',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            // Botón ir a SplashScreen
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SplashScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Ir Splash'),
            ),
            const SizedBox(height: 20),

            // Botón ir a LoginScreen
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Ir Login'),
            ),
            const SizedBox(height: 20),

            // Botón ir a MenuScreen
            ElevatedButton(
              onPressed: () {
                /*Navigator.push(
                  context,
                  //MaterialPageRoute(builder: (_) => const MenuClinicasPage()),
                );*/
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Ir Home'),
            ),

            // Botón ir a SelectionUserScreen
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SelectionUserScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Ir Seleccionar User'),
            ),

            // Botón ir a SelectionUserScreen
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PacienteDetalleScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Ir Datos Paciente'),
            ),

            // Botón ir a SelectionUserScreen
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RecetasScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Ir Receta'),
            ),
          ],
        ),
      ),
    );
  }
}

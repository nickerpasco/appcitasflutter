import 'package:flutter/material.dart';
import 'package:app_salud_citas/vistas/menu_screen.dart';
import 'package:app_salud_citas/vistas/main_screen.dart';



class SelectionUserScreen extends StatelessWidget {
  const SelectionUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.75;

    return Scaffold(
      body: Stack(
        children: [
          // Fondo completo
          SizedBox.expand(
            child: Image.asset(
              'assets/doctorHome.png',
              fit: BoxFit.cover,
            ),
          ),
          // Contenido encima
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // Botón: Soy Doctor
                  Center(
                    child: SizedBox(
                      width: buttonWidth,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MainScreen()),
                          );
                        },
                        icon: const Icon(Icons.medical_services, color: Colors.white),
                        label: const Text('DOCTOR'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6EE4A3),
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Color(0xFF6EE4A3)),
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Botón: Soy Paciente
                  Center(
                    child: SizedBox(
                      width: buttonWidth,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MainScreen()),
                          );
                        },
                        icon: const Icon(Icons.person, color: Colors.white),
                        label: const Text('PACIENTE'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6EE4A3),
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

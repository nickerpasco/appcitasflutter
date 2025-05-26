import 'package:flutter/material.dart';
import 'package:app_salud_citas/vistas/menu_screen.dart';
import 'package:app_salud_citas/vistas/main_screen.dart';

class SelectionUserScreen extends StatelessWidget {
  const SelectionUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.60;

    return Scaffold(
      body: Stack(
        children: [
          // Fondo completo
          SizedBox.expand(
            child: Image.asset(
              'assets/selectionuserNew.png',
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
                  const SizedBox(height: 20),

                  // Logo centrado arriba
                  Center(
                    child: Image.asset(
                      'assets/drLink.png',
                      height: 80,
                    ),
                  ),

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
                        icon: Image.asset(
                          'assets/iconDoctor.png',
                          height: 40,
                          width: 40,
                        ),
                        label: const Text('DOCTOR'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6EE4A3),
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Color(0xFF6EE4A3)),
                          minimumSize: const Size.fromHeight(40),
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
                        icon: Image.asset(
                          'assets/iconPaciente.png',
                          height: 40,
                          width: 40,
                        ),
                        label: const Text('PACIENTE'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF26A69A),
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(40),
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

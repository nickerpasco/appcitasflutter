import 'package:app_salud_citas/vistas/Vistastabs/ArchivoScreen.dart';
import 'package:app_salud_citas/vistas/Vistastabs/HistorialScreen.dart';
import 'package:app_salud_citas/vistas/Vistastabs/ProcedimientosScreen.dart';
import 'package:flutter/material.dart';
import 'package:app_salud_citas/vistas/menu_screen.dart';
import 'package:app_salud_citas/vistas/Vistastabs/AnamnesisScreen.dart';
import 'package:app_salud_citas/vistas/AgendarCitaScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _mostrarAgendar = false;

  void _onItemTapped(int index) {
    setState(() {
      _mostrarAgendar = false;
      _selectedIndex = index;
    });
  }

  void _irAAgendarCita() {
    setState(() {
      _mostrarAgendar = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      MenuClinicasPage(onAgendarCita: _irAAgendarCita),
      const PacienteDetalleScreen(),
      const RecetasScreen(),
      const HistorialScreen(),
      const ArchivoScreen(),
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Páginas principales
          Offstage(
            offstage: _mostrarAgendar,
            child: _pages[_selectedIndex],
          ),

          // Pantalla de Agendar Cita (mantiene la barra abajo)
          if (_mostrarAgendar)
            AgendarCitaScreen(
              nombreDoctor: 'Doctor demo',
              nombrePaciente: 'Paciente demo',
              idEspecialidad: 0,
              idEmpleado: 0,
              nombreEspecialidad: 'Especialidad demo',
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF2E687A),
        unselectedItemColor: Colors.black54,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: ''),
        ],
      ),
    );
  }
}

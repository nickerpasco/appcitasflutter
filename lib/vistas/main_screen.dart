import 'package:app_salud_citas/vistas/ArchivoScreen.dart';
import 'package:app_salud_citas/vistas/HistorialScreen.dart';
import 'package:app_salud_citas/vistas/RecetasScreen.dart';
import 'package:flutter/material.dart';
import 'package:app_salud_citas/vistas/menu_screen.dart';
import 'package:app_salud_citas/vistas/splah_screed.dart';
import 'package:app_salud_citas/vistas/menu_screen.dart';
import 'package:app_salud_citas/vistas/selection_user_screen.dart';
import 'package:app_salud_citas/vistas/PacienteDetalleScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    MenuClinicasPage(),
    PacienteDetalleScreen(),
    RecetasScreen(),
    HistorialScreen(),
    ArchivoScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
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

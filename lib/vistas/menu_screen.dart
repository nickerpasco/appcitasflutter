import 'dart:convert';

import 'package:app_salud_citas/models/LoginResponse.dart';
import 'package:app_salud_citas/vistas/AgendarCitaScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_salud_citas/providers/EspecialidadProvider.dart';
import 'package:app_salud_citas/models/especialidad.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuClinicasPage extends StatefulWidget {
  final VoidCallback onAgendarCita;

  const MenuClinicasPage({super.key, required this.onAgendarCita});

  @override
  State<MenuClinicasPage> createState() => _MenuClinicasPageState();
}

class _MenuClinicasPageState extends State<MenuClinicasPage> {
  String _nombreUsuario = 'Sin Nombre';

  Future<void> cargarNombreUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('user_data');
    if (json != null) {
      final data = LoginResponse.fromJson(jsonDecode(json));
      setState(() {
        _nombreUsuario = data.data?.persona?.nombre ?? 'Usuario';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<EspecialidadProvider>(context, listen: false).fetchEspecialidades();
    cargarNombreUsuario();
  }

  @override
  Widget build(BuildContext context) {
    final especialidadProvider = Provider.of<EspecialidadProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/slectionUserBackground.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.menu, color: Colors.black),
                      Image.asset('assets/drLink.png', height: 32),
                      const Icon(Icons.call, color: Colors.black),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Avatar y saludo
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/doctor.png'),
                  ),
                  const SizedBox(height: 12),
                  Text('Hola, $_nombreUsuario',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text('¿Cómo puedo ayudarte hoy?',
                      style: TextStyle(color: Colors.black)),
                  const SizedBox(height: 20),

                  // Buscador
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF5CFCCC), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: especialidadProvider.searchController,
                            decoration: const InputDecoration(
                              hintText: 'Buscar especialidad...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            especialidadProvider.buscarEspecialidades();
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Accesos rápidos
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      _IconButtonWithLabel(label: 'Agendar', assetImage: 'assets/perfilIco.png'),
                      _IconButtonWithLabel(label: 'Recetas', assetImage: 'assets/7.png'),
                      _IconButtonWithLabel(label: 'Procedimientos', assetImage: 'assets/8.png'),
                      _IconButtonWithLabel(label: 'Fotos', assetImage: 'assets/9.png'),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Notificación
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF5CFCCC), width: 1.5),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notificación de cita',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF003333),
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Usted tiene una cita en la sucursal de Miraflores\na las 03:18 pm del 25/04/2025',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),

                  // Lista de doctores
                  Expanded(
                    child: especialidadProvider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : especialidadProvider.especialidades.isEmpty
                        ? const Center(
                      child: Text(
                        'No se encontraron especialidades disponibles.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    )
                        : ListView.builder(
                      padding: const EdgeInsets.only(top: 8),
                      itemCount: especialidadProvider.especialidades.length,
                      itemBuilder: (context, index) {
                        final especialidad = especialidadProvider.especialidades[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              especialidad.especialidad ?? 'Sin nombre',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ...especialidad.empleados.map(
                                  (e) => _DoctorCard(
                                    name: e.empleado ?? 'Desconocido',
                                    specialty: especialidad.especialidad ?? '',
                                    location: 'Sucursal no especificada',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => AgendarCitaScreen(
                                            nombreDoctor: e.empleado ?? '',
                                            nombrePaciente: _nombreUsuario ?? '',
                                            idEspecialidad: especialidad.idEspecialidad ?? 0,
                                            idEmpleado: e.idEmpleado ?? 0,
                                            nombreEspecialidad: especialidad.especialidad ?? '',
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      },
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

class _IconButtonWithLabel extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String? assetImage;

  const _IconButtonWithLabel({this.icon, required this.label, this.assetImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        assetImage != null
            ? Image.asset(assetImage!, height: 32, width: 32)
            : Icon(icon, size: 32, color: Colors.green),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12))
      ],
    );
  }
}

class _DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String location;
  final VoidCallback? onTap;

  const _DoctorCard({
    required this.name,
    required this.specialty,
    required this.location,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage('assets/doctor.png'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF4B2C20))),
                  Text(specialty, style: const TextStyle(fontSize: 14)),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.green, size: 16),
                      const SizedBox(width: 4),
                      Text(location, style: const TextStyle(fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Row(
              children: const [
                Icon(Icons.star, color: Colors.amber, size: 18),
                SizedBox(width: 4),
                Text('4.9', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:app_salud_citas/models/LoginResponse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_salud_citas/providers/anamnesis_provider.dart';
import 'package:app_salud_citas/models/AnamnesisModel.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PacienteDetalleScreen extends StatefulWidget {
  const PacienteDetalleScreen({super.key});

  @override
  State<PacienteDetalleScreen> createState() => _PacienteDetalleScreenState();
}

class _PacienteDetalleScreenState extends State<PacienteDetalleScreen> {
  String _nombreUsuario = 'Sin Nombre';
  String _apellidoPuser = 'Sin Ap Pat.';
  String _apellidoMuser = 'Sin Ap Mat.';
  String _nombreCompleto = '';
  String _fechaNacFormated = '';

  Future<void> cargarNombreUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('user_data');
    if (json != null) {
      final data = LoginResponse.fromJson(jsonDecode(json));
      setState(() {
        _nombreUsuario = data.data?.persona?.nombre ?? 'Usuario';
        _apellidoPuser = data.data?.persona?.apellidoPaterno ?? '';
        _apellidoMuser = data.data?.persona?.apellidoMaterno ?? '';
        _nombreCompleto = _nombreUsuario + " " + _apellidoPuser + " " +_apellidoMuser;
        //FechaNacimiento
        final nacimiento = DateTime.parse(data.data?.persona?.fechaNacimiento ?? DateTime.now().toString() );
        final hoy = DateTime.now();

        int anos = hoy.year - nacimiento.year;
        int meses = hoy.month - nacimiento.month;

        if (meses < 0 || (meses == 0 && hoy.day < nacimiento.day)) {
        anos--;
        meses += 12;
        }

        _fechaNacFormated = '$anos años y $meses meses';


      });
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<AnamnesisProvider>(context, listen: false).cargarAnamnesis();
    cargarNombreUsuario();

  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AnamnesisProvider>(context);

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
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.menu, color: Colors.black),
                      Image.asset('assets/drLink.png', height: 32),
                      const Icon(Icons.call, color: Colors.black),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/doctor.png'),
                  ),
                  const SizedBox(height: 12),
                  Text('$_nombreCompleto',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('$_fechaNacFormated  |  WhatsApp',
                      style: TextStyle(color: Colors.grey)),

                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _TabButton(label: 'H. Médico', selected: true),
                          const SizedBox(width: 8),
                          _TabButton(label: 'Recetas'),
                          const SizedBox(width: 8),
                          _TabButton(label: 'Historial'),
                          const SizedBox(width: 8),
                          _TabButton(label: 'Archivos'),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Expanded(
                    child: provider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : provider.lista.isEmpty
                        ? const Center(child: Text('No se encontraron registros.'))
                        : SingleChildScrollView(
                      child: Column(
                        children: provider.lista.map((a) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: const Color(0xFF5CFCCC),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Paciente ${a.nombreCompleto ?? 'No definido'}'),
                                      Text(a.fechaFormateada ?? ''),
                                      const SizedBox(height: 12),
                                      const Text('Evolución y actualización del cuadro clínico', style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text(a.motivoConsulta ?? ''),
                                      const SizedBox(height: 8),
                                      const Text('Resultado de estudios', style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text(a.examenesAuxiliares ?? ''),
                                      const SizedBox(height: 8),
                                      const Text('Diagnóstico', style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text(a.diagnostico ?? ''),
                                      const SizedBox(height: 8),
                                      const Text('Pronóstico', style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text(a.tipoEnfermedad ?? ''),
                                      const SizedBox(height: 8),
                                      const Text('Plan de tratamiento', style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text(a.planTrabajo ?? ''),
                                      const SizedBox(height: 8),
                                      const Text('Nota adicional', style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text(a.adicional ?? ''),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: -30,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    width: 250,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF82EAC1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Resultados de laboratorio', style: TextStyle(fontWeight: FontWeight.bold)),
                                        Text(a.nombreCompletoDoctor ?? ''),
                                        Text(a.nombreCompletoDoctor ?? ''),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            a.fechaRegistro?.split('T').length == 2
                                                ? a.fechaRegistro!.split('T')[1].split(':').sublist(0, 2).join(':')
                                                : '',
                                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
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

class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;

  const _TabButton({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.white : const Color(0xFF5CFCCC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF5CFCCC),
          width: 1.5,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

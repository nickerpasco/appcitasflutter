import 'dart:convert';

import 'package:app_salud_citas/models/LoginResponse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/procedimiento_provider.dart';

class RecetasScreen extends StatefulWidget {
  const RecetasScreen({super.key});

  @override
  State<RecetasScreen> createState() => _RecetasScreenState();
}

class _RecetasScreenState extends State<RecetasScreen> {
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
    Provider.of<ProcedimientoProvider>(context, listen: false).cargarProcedimientos();
    cargarNombreUsuario();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProcedimientoProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset('assets/slectionUserBackground.png', fit: BoxFit.cover),
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
                      const Icon(Icons.menu),
                      Image.asset('assets/drLink.png', height: 32),
                      const Icon(Icons.call),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const CircleAvatar(radius: 40, backgroundImage: AssetImage('assets/doctor.png')),
                  const SizedBox(height: 12),
                  Text('$_nombreCompleto',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('$_fechaNacFormated  |  WhatsApp',
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),

                  const _TabSelector(),

                  // Selector de periodo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_left),
                        onPressed: () {},
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E687A),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Actual',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_right),
                        onPressed: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Expanded(
                    child: provider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                      itemCount: provider.procedimientos.length,
                      itemBuilder: (context, index) {
                        final p = provider.procedimientos[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFF5CFCCC)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Historial: ${p.codigoHistorial}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                    Text('Médico: ${p.medico}'),
                                    Text('Sucursal: ${p.sucursal}'),
                                    Text('Fecha: ${p.fechaFormateada}     Hora: ${p.horaFormateada}'),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              const CircleAvatar(
                                backgroundColor: Color(0xFF2E687A),
                                child: Icon(Icons.arrow_forward, color: Colors.white),
                              )
                            ],
                          ),
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

class _TabSelector extends StatelessWidget {
  const _TabSelector();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: const [
            _TabButton(label: 'H. Médico'),
            SizedBox(width: 8),
            _TabButton(label: 'Recetas', selected: true),
            SizedBox(width: 8),
            _TabButton(label: 'Historial'),
            SizedBox(width: 8),
            _TabButton(label: 'Archivos'),
          ],
        ),
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
        border: Border.all(color: const Color(0xFF5CFCCC), width: 1.5),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

import 'package:app_salud_citas/models/LoginResponse.dart';
import 'package:app_salud_citas/vistas/componentes/foto_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Asegúrate de tener tu clase LoginResponse definida correctamente
// import 'tu_modelo.dart';

class HistorialScreen extends StatefulWidget {
  const HistorialScreen({super.key});

  @override
  State<HistorialScreen> createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
  String _nombreUsuario = 'Sin Nombre';
  String _apellidoPuser = 'Sin Ap Pat.';
  String _apellidoMuser = 'Sin Ap Mat.';
  String _nombreCompleto = '';
  String _fechaNacFormated = '';

     String urlConFoto = '';
    String _primerNombre = '';
    String _primerapellido = '';

  @override
  void initState() {
    super.initState();
    cargarNombreUsuario();
  }

  Future<void> cargarNombreUsuario() async {
    final prefs = await SharedPreferences.getInstance();
      final jsonUrlImagen = prefs.getString('urlImagenUsuarioLogin');

    urlConFoto = jsonUrlImagen.toString();
    final json = prefs.getString('user_data');
    if (json != null) {
      final data = LoginResponse.fromJson(jsonDecode(json));
      setState(() {
        _nombreUsuario = data.data?.persona?.nombre ?? 'Usuario';
        _apellidoPuser = data.data?.persona?.apellidoPaterno ?? '';
        _apellidoMuser = data.data?.persona?.apellidoMaterno ?? '';
        _nombreCompleto =
            '$_nombreUsuario $_apellidoPuser $_apellidoMuser';

      _primerNombre = data.data?.persona?.nombre ?? '';
        _primerapellido = data.data?.persona?.apellidoPaterno ?? '';

        final nacimiento = DateTime.tryParse(data.data?.persona?.fechaNacimiento ?? '');
        if (nacimiento != null) {
          final hoy = DateTime.now();
          int anos = hoy.year - nacimiento.year;
          int meses = hoy.month - nacimiento.month;
          if (meses < 0 || (meses == 0 && hoy.day < nacimiento.day)) {
            anos--;
            meses += 12;
          }
          _fechaNacFormated = '$anos años y $meses meses';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      Image.asset(
                        'assets/drLink.png',
                        height: 32,
                      ),
                      const Icon(Icons.call, color: Colors.black),
                    ],
                  ),
                  const SizedBox(height: 20),
                   // const CircleAvatar(radius: 40, backgroundImage: AssetImage('assets/doctor.png')),
                     foto_ui(
                    imageUrl: urlConFoto,
                    firstName: _primerNombre,
                    lastName: _primerapellido,
                    radius: 50,
                  ),
                  const SizedBox(height: 12),
                  Text(_nombreCompleto,
                      style:
                          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('$_fechaNacFormated  |  WhatsApp',
                      style: const TextStyle(color: Colors.grey)),
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
                        children: const [
                          _TabButton(label: 'H. Médico'),
                          SizedBox(width: 8),
                          _TabButton(label: 'Procedimientos'),
                          SizedBox(width: 8),
                          _TabButton(label: 'Historial', selected: true),
                          SizedBox(width: 8),
                          _TabButton(label: 'Archivos'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFF5CFCCC)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('HISTORIALES Nº 1152539874',
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(height: 4),
                                  Text('Médico: MIKEY THOMPSSON HUGARTE'),
                                  Text('C. Asistencial: H.N. EDGARDO REBAGLIATI'),
                                  Text('Fecha: 26/4/2025      Hora: 03:35 pm'),
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                            CircleAvatar(
                              backgroundColor: Color(0xFF2E687A),
                              child: Icon(Icons.arrow_forward, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
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

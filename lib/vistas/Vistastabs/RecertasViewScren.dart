import 'package:app_salud_citas/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  List<dynamic> _tratamientos = [];

  @override
  void initState() {
    super.initState();
    cargarNombreUsuario();
    obtenerTratamientos();
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
        _nombreCompleto = '$_nombreUsuario $_apellidoPuser $_apellidoMuser';

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

  Future<void> obtenerTratamientos() async {
    // final url = Uri.parse('{{URLBASE}}/api/Hc_tratamiento/getAppTratamientos?id_historial_clinico=144');
    // final response = await http.get(url);



      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';
      final HC_DATA_ID = prefs.getInt('HC_DATA_ID') ?? '';

      final url = Uri.parse('${ApiConstants.baseUrl}/api/Hc_tratamiento/getAppTratamientos?id_historial_clinico=$HC_DATA_ID');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _tratamientos = data['data'];
      });
    } else {
      throw Exception('Error al cargar los tratamientos');
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
                  // Foto del usuario
                  foto_ui(
                    imageUrl: urlConFoto,
                    firstName: _primerNombre,
                    lastName: _primerapellido,
                    radius: 50,
                  ),
                  const SizedBox(height: 12),
                  Text(_nombreCompleto,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('$_fechaNacFormated  |  WhatsApp 3',
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
                          _TabButton(label: 'Anamnésis'),
                          const SizedBox(width: 8),
                          _TabButton(label: 'Procedimientos'),
                          const SizedBox(width: 8),
                          _TabButton(label: 'Recetas', selected: true),
                          const SizedBox(width: 8),
                          _TabButton(label: 'Archivos'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _tratamientos.isEmpty ? 0 : _tratamientos.length,
                      itemBuilder: (context, index) {
                        final tratamiento = _tratamientos[index];
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
                                    Text('Nombre: ${tratamiento['nombre']}',
                                        style: TextStyle(fontWeight: FontWeight.bold)),
                                    SizedBox(height: 4),
                                   
                                    Text('Fecha: ${tratamiento['fecha_registro']}'),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8),
                           GestureDetector(
  onTap: () {
  final tratamientoSeleccionado = _tratamientos[index];
  final detalles = tratamientoSeleccionado['detalle'] ?? [];

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(tratamientoSeleccionado['nombre']?.toString().trim() ?? 'Detalles del tratamiento'),
      content: detalles.isEmpty
          ? const Text('No hay detalles disponibles.')
          : SizedBox(
              width: double.maxFinite,
              height: 300,
              child: ListView.builder(
                itemCount: detalles.length,
                itemBuilder: (context, i) {
                  final d = detalles[i];
                  final fecha = d['fecha_registro'] != null
                      ? DateTime.tryParse(d['fecha_registro'])?.toLocal().toString().substring(0, 16) ?? '---'
                      : '---';

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         Text(
  'Nombre: ${d['nombre'] ?? '---'} | '
  'Dosis: ${d['dosis'] ?? '---'} ${d['unidadDosisText'] ?? ''} | '
  'Cant: ${d['cantidad'] ?? '---'} | '
  'Freq: ${d['frecuencia'] ?? '---'} ${d['unidadFrecuenciaText'] ?? ''} | '
  'Tiempo: ${d['tiempoTratamiento'] ?? '---'} ${d['unidadTiempoText'] ?? ''} | '
  'Obs: ${d['observacion'] ?? '---'} | '
  'FecReg: ${d['fecha_registro'] != null ? d['fecha_registro'].toString().substring(0, 10) : '---'}',
  style: const TextStyle(fontSize: 12),
),

                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
      actions: [
        TextButton(
          child: const Text('Cerrar'),
          onPressed: () => Navigator.pop(context),
        )
      ],
    ),
  );
},


 
  child: const CircleAvatar(
    backgroundColor: Color(0xFF2E687A),
    child: Icon(Icons.arrow_forward, color: Colors.white),
  ),
),
                            ],
                          ),
                        );
                      },
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

class LoginResponse {
  final Data? data;

  LoginResponse({this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  final Persona? persona;

  Data({this.persona});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      persona: json['persona'] != null ? Persona.fromJson(json['persona']) : null,
    );
  }
}

class Persona {
  final String? nombre;
  final String? apellidoPaterno;
  final String? apellidoMaterno;
  final String? fechaNacimiento;

  Persona({this.nombre, this.apellidoPaterno, this.apellidoMaterno, this.fechaNacimiento});

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      nombre: json['nombre'],
      apellidoPaterno: json['apellidoPaterno'],
      apellidoMaterno: json['apellidoMaterno'],
      fechaNacimiento: json['fechaNacimiento'],
    );
  }
}

Widget foto_ui({String imageUrl = '', String firstName = '', String lastName = '', double radius = 50}) {
  return CircleAvatar(
    radius: radius,
    backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
    child: imageUrl.isEmpty
        ? Text(
            '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          )
        : null,
  );
}

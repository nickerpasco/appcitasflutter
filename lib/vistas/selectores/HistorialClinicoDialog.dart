import 'dart:convert';
import 'package:app_salud_citas/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HistorialClinicoDialog extends StatefulWidget {
  final int idUneg;
  final int idPaciente;
  final Function(HistorialClinico) onSelectHistorial;

  const HistorialClinicoDialog({
    Key? key,
    required this.idUneg,
    required this.idPaciente,
    required this.onSelectHistorial,  // Callback
  }) : super(key: key);

  @override
  State<HistorialClinicoDialog> createState() => _HistorialClinicoDialogState();

  static void show(BuildContext context, {
    required int idUneg,
    required int idPaciente,
    required Function(HistorialClinico) onSelectHistorial,  // Callback
  }) {
    showDialog(
      context: context,
      builder: (_) => HistorialClinicoDialog(
        idUneg: idUneg,
        idPaciente: idPaciente,
        onSelectHistorial: onSelectHistorial,  // Pasar el callback
      ),
    );
  }
}

class _HistorialClinicoDialogState extends State<HistorialClinicoDialog> {
  late Future<List<String>> _futureFechas;
  late Future<List<HistorialClinico>> _futureHistorial;
  int _fechaIndex = 0; // Índice de la fecha actual
  List<String> fechas = [];

  @override
  void initState() {
    super.initState();
    _futureFechas = _fetchFechas(); // Llamada para obtener las fechas de la API
  }

  // Obtener fechas de la API
  Future<List<String>> _fetchFechas() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    

final urlPath = ApiConstants.baseUrl;


    final url = Uri.parse('$urlPath/api/Historial_clinico/listFechasCitasPaciente')
      .replace(queryParameters: {
        'id_uneg': widget.idUneg.toString(),
        'id_paciente': widget.idPaciente.toString(),
      });

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> list = data['data'];
      return list.map((json) => json['fecha_cita'] as String).toList();
    } else {
      throw Exception('Error al cargar las fechas');
    }
  }

  // Obtener historial clínico de una fecha específica
  Future<List<HistorialClinico>> _fetchHistorial(String fecha) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    

final urlPath = ApiConstants.baseUrl;

    final url = Uri.parse('$urlPath/api/Historial_clinico/historialClinicoPaginatexFecha')
      .replace(queryParameters: {
        'id_uneg': widget.idUneg.toString(),
        'id_paciente': widget.idPaciente.toString(),
        'fecha': fecha,
      });

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> list = data['data'];
      return list.map((json) => HistorialClinico.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar historial clínico');
    }
  }

  void _onFechaChange(int change) {
    setState(() {
      _fechaIndex = (_fechaIndex + change) % fechas.length;
      _futureHistorial = _fetchHistorial(fechas[_fechaIndex]);
    });
  }

  void _onHistorialSelect(HistorialClinico historial) {
    widget.onSelectHistorial(historial); // Llamar el callback con el objeto seleccionado
    Navigator.pop(context); // Cerrar el diálogo después de la selección
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Historial Clínico'),
      content: SizedBox(
        width: double.maxFinite,
        child: FutureBuilder<List<String>>(
          future: _futureFechas,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No se encontraron fechas.');
            }

            fechas = snapshot.data!; // Asigna las fechas obtenidas
            _futureHistorial = _fetchHistorial(fechas[_fechaIndex]);

            return Column(
              children: [
                // Selector de fecha
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_left),
                      onPressed: () => _onFechaChange(-1), // Navegar hacia atrás
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E687A),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        fechas[_fechaIndex], // Mostrar la fecha actual
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_right),
                      onPressed: () => _onFechaChange(1), // Navegar hacia adelante
                    ),
                  ],
                ),

                // ListView de historial clínico
                Expanded(
                  child: FutureBuilder<List<HistorialClinico>>(
                    future: _futureHistorial,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No se encontraron datos.');
                      }

                      final items = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (_, index) {
                          final item = items[index];
                          return GestureDetector(
                            onTap: () => _onHistorialSelect(item),  // Seleccionar el historial
                            child: Container(
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
                                        Text('Historial: ${item.codigoHistorial}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                        Text('Especialidad: ${item.especialidadDescripcion}'),
                                        Text('Fecha: ${item.fechaRegistroFormat}'),
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
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}

class HistorialClinico {
  final int idHistorialClinico;
  final String codigoHistorial;
  final String especialidadDescripcion;
  final String fechaRegistroFormat;

  HistorialClinico({
    required this.idHistorialClinico,
    required this.codigoHistorial,
    required this.especialidadDescripcion,
    required this.fechaRegistroFormat,
  });

  factory HistorialClinico.fromJson(Map<String, dynamic> json) {
    return HistorialClinico(
      idHistorialClinico: json['id_historial_clinico'],
      codigoHistorial: json['codigo_historial'],
      especialidadDescripcion: json['especialidadDescripcion'],
      fechaRegistroFormat: json['fecha_registroFormat'],
    );
  }
}

 

import 'package:app_salud_citas/services/CitaService.dart';

class CitaController {
  final CitaService _citaService;

  CitaController() : _citaService = CitaService();

  Future<Map<String, dynamic>> agendarCita(Map<String, dynamic> payload) async {
    return await _citaService.enviarCita(payload);
  }
}

import 'dart:convert';
import 'package:app_salud_citas/models/LoginResponse.dart';
import 'package:app_salud_citas/models/unavailable_time_response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HorarioService {
  Future<List<String>> obtenerHorasNoDisponibles({
    required String fecha,
    required int idUneg,
    required int idEmpleado,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    final userData = prefs.getString('user_data');

    if (userData == null) throw Exception('No hay sesión activa');

    final loginResponse = LoginResponse.fromJson(jsonDecode(userData));
    //final idCliente = loginResponse.data?.pacienteEmpresa?.first.idCliente ?? 0;
    //final idCliente = 13;
    final idUneg = loginResponse.data?.pacienteEmpresa?.first.idUneg ?? 0;

    final url = Uri.parse(
      'https://web-doctorlink-service.itbcpwebservices.com/Citas/unavailable-time?fechaInicio=$fecha&id_uneg=$idUneg&id_empleado=$idEmpleado',
      //'https://web-doctorlink-service.itbcpwebservices.com/Citas/unavailable-time?fechaInicio=$fecha&id_uneg=1&id_empleado=74',
    );

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final data = UnavailableTimeResponse.fromJson(json.decode(response.body));
      final horas = data.data.expand((d) => d.horaInicio).map((h) => h.horaInicio).toList();
      return horas;
    } else {
      throw Exception('Error al obtener horas no disponibles');
    }
  }
}

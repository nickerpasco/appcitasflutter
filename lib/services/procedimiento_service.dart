import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/procedimiento_model.dart';
import '../constants/api_constants.dart';

class ProcedimientoService {
  Future<List<DetalleProcedimiento>> fetchProcedimientos() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    final userJson = prefs.getString('user_data');

    if (userJson == null) throw Exception('Usuario no logueado');
    final userMap = jsonDecode(userJson);
    final pacienteEmpresa = userMap['data']['pacienteEmpresa'][0];
    final idCliente = pacienteEmpresa['id_cliente'];
    //final idCliente = 30;
    final idUneg = pacienteEmpresa['id_uneg'];

  final HC_DATA_ID = prefs.getInt('HC_DATA_ID') ?? '';



final url = Uri.parse('${ApiConstants.baseUrl}/api/Hc_procedimiento/list-app?id_historial_clinico=$HC_DATA_ID');
    // final url = Uri.parse('${ApiConstants.baseUrl}/api/Hc_procedimiento/list-app?id_uneg=$idUneg&id_cliente=$idCliente');




    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse['data'] ?? [];

      String dataJson = json.encode(data); // Convertir a JSON (String)

      final procedimientos = data.expand((e) {

        
        return (e['procedimientos'] as List).map((i) => DetalleProcedimiento.fromJson(i));


      }).toList();
      return List<DetalleProcedimiento>.from(procedimientos);
    } else {
      throw Exception('Error al obtener procedimientos');
    }
  }
}

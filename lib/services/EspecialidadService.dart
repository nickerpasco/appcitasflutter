import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/especialidad.dart';
import '../models/LoginResponse.dart';
import '../constants/api_constants.dart';

class EspecialidadService {
  Future<List<EspecialidadModel>> fetchEspecialidades({String? especialidad}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    final userDataRaw = prefs.getString('user_data');

    if (userDataRaw == null) throw Exception('Sesión no encontrada');

    final userData = LoginResponse.fromJson(jsonDecode(userDataRaw));
    final idUneg = userData.data?.pacienteEmpresa?.first.idUneg;

    if (idUneg == null) throw Exception('ID_UNEG no disponible');

    // Construir URL con query parameters
    final queryParams = {
      'id_uneg': idUneg.toString(),
      if (especialidad != null && especialidad.isNotEmpty) 'especialidad': especialidad,
    };
    final uri = Uri.parse(ApiConstants.baseUrl + '/api/Especialidad/seeker').replace(queryParameters: queryParams);

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> dataList = jsonResponse['data'];
      return dataList.map((e) => EspecialidadModel.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener especialidades: ${response.statusCode}');
    }
  }
}

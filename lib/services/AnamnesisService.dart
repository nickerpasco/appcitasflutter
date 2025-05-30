import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/AnamnesisModel.dart';
import '../constants/api_constants.dart';
import '../models/LoginResponse.dart';

class AnamnesisService {
  Future<List<AnamnesisModel>> fetchAnamnesis() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    final userDataJson = prefs.getString('user_data');

    if (userDataJson == null) {
      throw Exception('No hay datos de usuario almacenados');
    }

    final loginResponse = LoginResponse.fromJson(jsonDecode(userDataJson));
    final idUneg = loginResponse.data?.pacienteEmpresa?.first.idUneg ?? 0;
    final idCliente = loginResponse.data?.pacienteEmpresa?.first.idCliente ?? 0;

    if (idCliente == null || idUneg == null) {
      throw Exception('Faltan datos para construir la URL');
    }

    final url = Uri.parse(
      '${ApiConstants.baseUrl}/api/Hc_anamesis/list?id_paciente=$idCliente&id_uneg=$idUneg',
    );

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> dataList = jsonResponse['data'];
      return dataList.map((e) => AnamnesisModel.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener anamnesis');
    }
  }

}
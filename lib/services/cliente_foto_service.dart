import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cliente_foto_model.dart';
import '../constants/api_constants.dart';
import '../models/LoginResponse.dart';

class ClienteFotoService {
  Future<List<ClienteFotoModel>> getFotosCliente() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    final userData = prefs.getString('user_data');

    if (userData == null) throw Exception('No hay sesión activa');

    final loginResponse = LoginResponse.fromJson(jsonDecode(userData));
    final idCliente = loginResponse.data?.pacienteEmpresa?.first.idCliente ?? 0;
    // final idCliente = 13;
    final idUneg = loginResponse.data?.pacienteEmpresa?.first.idUneg ?? 0;

    final url = Uri.parse('${ApiConstants.baseUrl}/api/Cliente_foto/list?id_cliente=$idCliente&id_uneg=$idUneg');

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse['data'];
      return data.map((e) => ClienteFotoModel.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener las fotos del cliente');
    }
  }
}

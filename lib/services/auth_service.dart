import 'package:app_salud_citas/models/LoginResult.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/LoginResponse.dart';
import '../constants/api_constants.dart';

class AuthService {
  Future<LoginResult?> loginPaciente(String identifier, String signature) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndpoint);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'identifier': identifier,
          'signature': signature,
        },
        body: jsonEncode({}),
      );

<<<<<<< HEAD
    print(response);
=======
      print('status: $response.statusCode' );
>>>>>>> 684f69ccf1a9971bf23a3550907b855e0939583e

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final loginResponse = LoginResponse.fromJson(responseBody);

        // Obtener token del header
        final token = response.headers['token'] ?? '';

        return LoginResult(response: loginResponse, token: token);
      } else {
        return null;
      }
    } catch (e) {
      print('Error en login: $e');
      return null;
    }
  }
}

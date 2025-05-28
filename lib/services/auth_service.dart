import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/LoginResponse.dart';
import '../constants/api_constants.dart';

class AuthService {
  Future<LoginResponse?> loginPaciente(String identifier, String signature) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndpoint);

    try {
      final response = await http.post(
        url,
        headers: {
          'identifier': identifier,
          'signature': signature,
        },
        body: jsonEncode({}),
      );

    print(response);

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print('Error en login: $e');
      return null;
    }
  }
}

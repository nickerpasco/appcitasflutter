import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app_salud_citas/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class CitaService {
  final String baseUrl;


    final _apiUrl = Uri.parse('${ApiConstants.baseUrl}');



  CitaService({required this.baseUrl});

  Future<Map<String, dynamic>> enviarCita(Map<String, dynamic> payload) async {
    final url = Uri.parse('$baseUrl/secengine/auth/login-paciente');

    try {
      final response = await http
          .post(
            url,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
            body: jsonEncode(payload),
          )
          .timeout(const Duration(seconds: 15)); // timeout de 15s

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'success': true,
          'data': jsonDecode(response.body),
        };
      } else {
        return {
          'success': false,
          'error':
              'Error HTTP ${response.statusCode}: ${response.reasonPhrase}',
          'body': response.body,
        };
      }
    } on SocketException {
      return {
        'success': false,
        'error': 'Error de red: No se pudo conectar con el servidor.',
      };
    } on TimeoutException {
      return {
        'success': false,
        'error': 'Tiempo de espera agotado al conectar con el servidor.',
      };
    } on FormatException {
      return {
        'success': false,
        'error': 'Respuesta con formato inválido.',
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Error inesperado: $e',
      };
    }
  }
}

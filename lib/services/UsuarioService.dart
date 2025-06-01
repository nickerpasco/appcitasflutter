import 'dart:convert';
import 'package:app_salud_citas/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class UsuarioService {
  

    final _apiUrl = Uri.parse('${ApiConstants.baseUrl}/api/Cliente/create-patient');




  // Función que construye y envía el JSON con la estructura requerida
  Future<Map<String, dynamic>> crearPaciente({
    required String nombre,
    required String apellidoPaterno,
    required String apellidoMaterno,
    required String fechaNacimiento,
    required int tipoDocumento,
    required String dni,
    required String email,
    required String telefono,
    required String passwordHash,
    String urlFoto = 'https://example.com/foto.jpg',
    int idUneg = 1,
    int tipoUsuario = 1,
    bool flagTelefono = true,
  }) async {
    // Construimos el JSON directamente
    final requestBody = {
      'idUneg': idUneg,
      'Cliente': {
        'urlFoto': urlFoto,
      },
      'Persona': {
        'Nombre': nombre,
        'Apellido_paterno': apellidoPaterno,
        'Apellido_materno': apellidoMaterno,
        'Fecha_nacimiento': fechaNacimiento,
        'tipoDocumento': tipoDocumento,
        'Dni': dni,
        'Email': email,
        'Falg_telefono': flagTelefono,
        'Telefono': telefono,
      },
      'Usuario': {
        'Tipo_usuario': tipoUsuario,
        'PasswordHash': passwordHash,
      },
    };


  //print(requestBody);

    try {
      final response = await http.post(
        _apiUrl,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          // Agrega aquí otros headers si son necesarios (como Authorization)
        },
        body: jsonEncode(requestBody),
      );

    print(response.statusCode);


    if(response.statusCode == 500){
       return {
        'success': false,
        'statusCode': response.statusCode,
        'body': jsonDecode(response.body),
      };
    }

      return {
        'success': response.statusCode == 200 || response.statusCode == 201,
        'statusCode': response.statusCode,
        'body': jsonDecode(response.body),
      };
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  // Versión alternativa como constante (aunque no es muy útil para datos dinámicos)
  static const Map<String, dynamic> pacienteEjemplo = {
    'idUneg': 1,
    'Cliente': {
      'urlFoto': 'https://example.com/foto.jpg',
    },
    'Persona': {
      'Nombre': 'Juan',
      'Apellido_paterno': 'Pérez',
      'Apellido_materno': 'González',
      'Fecha_nacimiento': '1990-05-15',
      'tipoDocumento': 1,
      'Dni': '987645322',
      'Email': 'pru@example.com',
      'Falg_telefono': true,
      'Telefono': '987654321',
    },
    'Usuario': {
      'Tipo_usuario': 1,
      'PasswordHash': '123456',
    },
  };
}
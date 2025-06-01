import 'package:app_salud_citas/utils/NavigationHelper.dart';
import 'package:app_salud_citas/utils/UIHelper.dart';
import 'package:app_salud_citas/vistas/NewLoginScreen.dart';
import 'package:app_salud_citas/vistas/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_salud_citas/models/paciente_model.dart';
import 'package:app_salud_citas/services/UsuarioService.dart';

class PacienteController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String selectedDocType = 'DNI';
  String selectedCountryCode = '+51';
  String selectedFlag = '🇵🇪';

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController documentoController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController claveController = TextEditingController();

  String? selectedDia;
  String? selectedMes;
  String? selectedAnio;

  final List<Map<String, String>> countryOptions = [
    {'code': '+51', 'flag': '🇵🇪'},
    {'code': '+54', 'flag': '🇦🇷'},
    {'code': '+57', 'flag': '🇨🇴'},
    {'code': '+34', 'flag': '🇪🇸'},
  ];

  Future<Paciente?> submitForm(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      final paciente = Paciente(
        tipoDoc: selectedDocType,
        documento: documentoController.text,
        nombre: nombreController.text,
        apellidos: apellidoController.text,
        telefono: telefonoController.text,
        email: emailController.text,
        fechaNacimiento: "$selectedDia/$selectedMes/$selectedAnio",
        usuario: usuarioController.text,
        clave: claveController.text,
        codigoPais: selectedCountryCode,
        banderaPais: selectedFlag,
      );

      print("Paciente a registrar:");
      print(paciente.toJson());

      final uService = UsuarioService();

      try {
        final resultado = await uService.crearPaciente(
          nombre: paciente.nombre,
          apellidoPaterno: _getApellidoPaterno(paciente.apellidos),
          apellidoMaterno: _getApellidoMaterno(paciente.apellidos),
          fechaNacimiento: _formatearFecha(paciente.fechaNacimiento),
          tipoDocumento: _mapTipoDocumento(paciente.tipoDoc),
          dni: paciente.documento,
          email: paciente.email,
          telefono: paciente.telefono,
          passwordHash: paciente.clave,
        );

        if (resultado['success']) {
          print('✅ Paciente creado exitosamente');



      NavigationHelper.navegarYReemplazar(context, NewLoginScreen());



          UIHelper.mostrarMensajeDialog(
        context: context,
        titulo: 'Exito',
        mensaje: 'Usuario creado correctamente...' ,
        icono: Icons.done_outline_rounded,
        colorIcono: Colors.green,
        );


        } else {

          // final decodedBody = resultado['body'];
          // var mensaje = resultado['body'];
        final message = resultado['body']['message'];

       // UIHelper.mostrarMensaje(context, message);

        UIHelper.mostrarMensajeDialog(
        context: context,
        titulo: 'Error',
        mensaje: 'No se pudo registrar el paciente Detalle :' + message,
        icono: Icons.error_outline,
        colorIcono: Colors.redAccent,
        );


       


          print('❌ Error en la creación: ${resultado['error']}');
        }

        return paciente;
      } catch (e) {
        print('⚠️ Excepción al crear paciente: $e');
        return null;
      }
    }

    return null;
  }

  void dispose() {
    nombreController.dispose();
    apellidoController.dispose();
    documentoController.dispose();
    telefonoController.dispose();
    emailController.dispose();
    usuarioController.dispose();
    claveController.dispose();
  }

  // Funciones auxiliares

  String _formatearFecha(String fecha) {
    // De "31/12/2000" a "2000-12-31"
    final partes = fecha.split('/');
    if (partes.length == 3) {
      return '${partes[2]}-${partes[1]}-${partes[0]}';
    }
    return fecha;
  }

  int _mapTipoDocumento(String tipoDoc) {
    switch (tipoDoc.toUpperCase()) {
      case 'DNI':
        return 1;
      case 'CE':
        return 2;
      default:
        return 0;
    }
  }

  String _getApellidoPaterno(String apellidos) {
    final partes = apellidos.split(' ');
    return partes.isNotEmpty ? partes.first : '';
  }

  String _getApellidoMaterno(String apellidos) {
    final partes = apellidos.split(' ');
    return partes.length > 1 ? partes[1] : '';
  }
}

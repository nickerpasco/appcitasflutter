import 'package:flutter/material.dart';
import '../services/horario_service.dart';

class HorarioProvider with ChangeNotifier {
  final HorarioService _service = HorarioService();

  String? doctor;
  String? especialidad;
  String? nombre;
  String? telefono;
  String? horaSeleccionada;

  String? errorDoctor;
  String? errorEspecialidad;
  String? errorNombre;
  String? errorTelefono;
  String? errorHora;

  void setDoctor(String value) {
    doctor = value;
    notifyListeners();
  }

  void setEspecialidad(String value) {
    especialidad = value;
    notifyListeners();
  }

  void setNombre(String value) {
    nombre = value;
    notifyListeners();
  }

  void setTelefono(String value) {
    telefono = value;
    notifyListeners();
  }

  void setHora(String value) {
    horaSeleccionada = value;
    notifyListeners();
  }


  bool validarFormulario() {
    errorDoctor = doctor == null || doctor!.isEmpty ? 'Seleccione un doctor' : null;
    errorEspecialidad = especialidad == null || especialidad!.isEmpty ? 'Seleccione una especialidad' : null;
    errorNombre = nombre == null || nombre!.isEmpty ? 'Ingrese su nombre' : null;
    errorTelefono = telefono == null || telefono!.isEmpty ? 'Ingrese su teléfono' : null;
    errorHora = horaSeleccionada == null || horaSeleccionada!.isEmpty ? 'Seleccione una hora' : null;

    notifyListeners();

    return errorDoctor == null &&
        errorEspecialidad == null &&
        errorNombre == null &&
        errorTelefono == null &&
        errorHora == null;
  }

  List<String> _horasNoDisponibles = [];
  List<String> get horasNoDisponibles => _horasNoDisponibles;

  Future<void> cargarHorasNoDisponibles({
    required DateTime fecha,
    required int idUneg,
    required int idEmpleado,
  }) async {
    try {
      final fechaStr = '${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}';
      _horasNoDisponibles = await _service.obtenerHorasNoDisponibles(
        fecha: fechaStr,
        idUneg: idUneg,
        idEmpleado: idEmpleado,
      );
      notifyListeners();
    } catch (e) {
      print('Error al cargar horas no disponibles: $e');
      _horasNoDisponibles = [];
      notifyListeners();
    }
  }
}

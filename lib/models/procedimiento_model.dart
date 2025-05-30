import 'package:intl/intl.dart';

class DetalleProcedimiento {
  final String nombre;
  final String medico;
  final String sucursal;
  final String fecha;
  final String hora;
  final String codigoHistorial;

  DetalleProcedimiento({
    required this.nombre,
    required this.medico,
    required this.sucursal,
    required this.fecha,
    required this.hora,
    required this.codigoHistorial,
  });

  factory DetalleProcedimiento.fromJson(Map<String, dynamic> json) {
    return DetalleProcedimiento(
      nombre: json['nombre'] ?? '',
      medico: json['medico'] ?? '',
      sucursal: json['sucursal'] ?? '',
      fecha: json['fecha'] ?? '',
      hora: json['hora'] ?? '',
      codigoHistorial: json['codigo_historial'] ?? '',
    );
  }

  String get fechaFormateada {
    try {
      final fechaParsed = DateTime.parse(fecha);
      return DateFormat('yyyy-MM-dd').format(fechaParsed);
    } catch (_) {
      return fecha;
    }
  }

  String get horaFormateada {
    try {
      final horaParsed = DateFormat("HH:mm:ss").parse(hora);
      return DateFormat('hh:mm a').format(horaParsed).toLowerCase(); // ejemplo: 03:35 pm
    } catch (_) {
      return hora;
    }
  }
}

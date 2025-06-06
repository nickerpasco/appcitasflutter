class HistorialClinico {
  final int idHistorialClinico;
  final int idUneg;
  final int idSucursal;
  final int idDoctor;
  final int idPaciente;
  final int idEspecialidad;
  final String? descripcion;
  final DateTime fechaRegistro;
  final String userRegister;
  final DateTime? fechaModifica;
  final String? userModifica;
  final bool estadoReg;
  final String codigoHistorial;
  final String especialidadDescripcion;
  final String fechaRegistroFormat;

  HistorialClinico({
    required this.idHistorialClinico,
    required this.idUneg,
    required this.idSucursal,
    required this.idDoctor,
    required this.idPaciente,
    required this.idEspecialidad,
    this.descripcion,
    required this.fechaRegistro,
    required this.userRegister,
    this.fechaModifica,
    this.userModifica,
    required this.estadoReg,
    required this.codigoHistorial,
    required this.especialidadDescripcion,
    required this.fechaRegistroFormat,
  });

  factory HistorialClinico.fromJson(Map<String, dynamic> json) {
    return HistorialClinico(
      idHistorialClinico: json['id_historial_clinico'],
      idUneg: json['id_uneg'],
      idSucursal: json['id_sucursal'],
      idDoctor: json['id_doctor'],
      idPaciente: json['id_paciente'],
      idEspecialidad: json['id_especialidad'],
      descripcion: json['descripcion'],
      fechaRegistro: DateTime.parse(json['fecha_registro']),
      userRegister: json['user_register'],
      fechaModifica: json['fecha_modifica'] != null
          ? DateTime.tryParse(json['fecha_modifica'])
          : null,
      userModifica: json['user_modifica'],
      estadoReg: json['estado_reg'],
      codigoHistorial: json['codigo_historial'],
      especialidadDescripcion: json['especialidadDescripcion'],
      fechaRegistroFormat: json['fecha_registroFormat'],
    );
  }
}

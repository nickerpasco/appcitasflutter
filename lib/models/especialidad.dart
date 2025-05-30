class EspecialidadModel {
  final int? idEspecialidad;
  final String? especialidad;
  final List<EmpleadoModel> empleados;

  EspecialidadModel({
    this.idEspecialidad,
    this.especialidad,
    required this.empleados,
  });

  factory EspecialidadModel.fromJson(Map<String, dynamic> json) {
    return EspecialidadModel(
      idEspecialidad: json['id_especialidad'],
      especialidad: json['especialidad'],
      empleados: (json['empleados'] as List)
          .map((e) => EmpleadoModel.fromJson(e))
          .toList(),
    );
  }
}

class EmpleadoModel {
  final int? idEmpleado;
  final String? empleado;

  EmpleadoModel({this.idEmpleado, this.empleado});

  factory EmpleadoModel.fromJson(Map<String, dynamic> json) {
    return EmpleadoModel(
      idEmpleado: json['id_empleado'],
      empleado: json['empleado'],
    );
  }
}

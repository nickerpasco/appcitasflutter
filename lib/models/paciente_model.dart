class Paciente {
  String tipoDoc;
  String documento;
  String nombre;
  String apellidos;
  String telefono;
  String email;
  String fechaNacimiento;
  String usuario;
  String clave;
  String codigoPais;
  String banderaPais;

  Paciente({
    required this.tipoDoc,
    required this.documento,
    required this.nombre,
    required this.apellidos,
    required this.telefono,
    required this.email,
    required this.fechaNacimiento,
    required this.usuario,
    required this.clave,
    required this.codigoPais,
    required this.banderaPais,
  });

  Map<String, dynamic> toJson() {
    return {
      'tipoDoc': tipoDoc,
      'documento': documento,
      'nombre': nombre,
      'apellidos': apellidos,
      'telefono': '$codigoPais $telefono',
      'email': email,
      'fechaNacimiento': fechaNacimiento,
      'usuario': usuario,
      'clave': clave,
      'codigoPais': codigoPais,
      'banderaPais': banderaPais,
    };
  }
}
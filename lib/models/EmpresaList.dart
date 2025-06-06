import 'dart:convert';

class EmpresaList {
  final int idUneg;
  final String ruc;
  final String razonSocial;
  final String? celular;
  final bool estadoReg;
  final bool inscripcionComplete;
  final EmpresaPlan? empresaPlanesSuscriptions;

  EmpresaList({
    required this.idUneg,
    required this.ruc,
    required this.razonSocial,
    this.celular,
    required this.estadoReg,
    required this.inscripcionComplete,
    this.empresaPlanesSuscriptions,
  });

  factory EmpresaList.fromJson(Map<String, dynamic> json) {
    return EmpresaList(
      idUneg: json['idUneg'],
      ruc: json['ruc'],
      razonSocial: json['razonSocial'],
      celular: json['celular'],
      estadoReg: json['estadoReg'],
      inscripcionComplete: json['inscripcionComplete'],
      empresaPlanesSuscriptions: json['empresaPlanesSuscriptions'] != null
          ? EmpresaPlan.fromJson(json['empresaPlanesSuscriptions'])
          : null,
    );
  }
}

class EmpresaPlan {
  final int id_empresaPlanesSuscriptions;
  final int cantidadPacientesPlan;
  final int cantidadDoctoresPlan;
  final bool flagPacienteIlimitado;
  final bool flagAppMovil;
  final bool vencido;

  EmpresaPlan({
    required this.id_empresaPlanesSuscriptions,
    required this.cantidadPacientesPlan,
    required this.cantidadDoctoresPlan,
    required this.flagPacienteIlimitado,
    required this.flagAppMovil,
    required this.vencido,
  });

  factory EmpresaPlan.fromJson(Map<String, dynamic> json) {
    return EmpresaPlan(
      id_empresaPlanesSuscriptions: json['id_empresaPlanesSuscriptions'],
      cantidadPacientesPlan: json['cantidadPacientesPlan'],
      cantidadDoctoresPlan: json['cantidadDoctoresPlan'],
      flagPacienteIlimitado: json['flagPacienteIlimitado'],
      flagAppMovil: json['flagAppMovil'],
      vencido: json['vencido'],
    );
  }
}

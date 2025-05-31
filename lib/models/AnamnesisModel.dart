import 'package:intl/intl.dart';

class AnamnesisModel {
  final String nombreCompleto;
  final String fechaRegistro;
  final String antecedentesPatologicos;
  final String antecedentesFamiliares;
  final String alergiasMedicamentos;
  final String motivoConsulta;
  final String tipoEnfermedad;
  final String examenFisicoMental;
  final String peso;
  final String pa;
  final String fc;
  final String diagnostico;
  final String examenesAuxiliares;
  final String tratamientos;
  final String planTrabajo;
  final String adicional;
  final String nombreCompletoDoctor;

  AnamnesisModel({
    required this.nombreCompleto,
    required this.fechaRegistro,
    required this.antecedentesPatologicos,
    required this.antecedentesFamiliares,
    required this.alergiasMedicamentos,
    required this.motivoConsulta,
    required this.tipoEnfermedad,
    required this.examenFisicoMental,
    required this.peso,
    required this.pa,
    required this.fc,
    required this.diagnostico,
    required this.examenesAuxiliares,
    required this.tratamientos,
    required this.planTrabajo,
    required this.adicional,
    required this.nombreCompletoDoctor,
  });

  factory AnamnesisModel.fromJson(Map<String, dynamic> json) => AnamnesisModel(
    nombreCompleto: json['nombre_completo'] ?? '',
    fechaRegistro: json['fecha_registro'] ?? '',
    antecedentesPatologicos: json['antecedentesPatologicos'] ?? '',
    antecedentesFamiliares: json['antecedentesFamiliares'] ?? '',
    alergiasMedicamentos: json['alergiasMedicamentos'] ?? '',
    motivoConsulta: json['motivoConsulta'] ?? '',
    tipoEnfermedad: json['tipoEnfermedad'] ?? '',
    examenFisicoMental: json['examenFisicoMental'] ?? '',
    peso: json['peso'] ?? '',
    pa: json['pa'] ?? '',
    fc: json['fc'] ?? '',
    diagnostico: json['diagnostico'] ?? '',
    examenesAuxiliares: json['examenesAuxiliares'] ?? '',
    tratamientos: json['tratamientos'] ?? '',
    planTrabajo: json['planTrabajo'] ?? '',
    adicional: json['adicional'] ?? '',
    nombreCompletoDoctor: json['nombre_completo_doctor'] ?? '',
  );

  String get fechaFormateada {
    if (fechaRegistro == null) return '';
    final date = DateTime.tryParse(fechaRegistro!);
    if (date == null) return '';
    return DateFormat("d MMMM y - hh:mm a", 'es').format(date);
  }
}
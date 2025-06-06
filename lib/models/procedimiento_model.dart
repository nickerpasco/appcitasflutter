import 'dart:convert';

class DetalleProcedimiento {
  final int idHcProcedimiento;
  final int idHistorialClinico;
  final int idUneg;
  final int idSucursal;
  final String descripcion;
  final int idPlantilla;
  final String urlTrazos;
  final String fechaRegistro;
  final String userRegister;
  final String? fechaModifica;
  final String? userModifica;
  final bool estadoReg;
  final String nombre;
  final List<ProcedimientoDetalle> hcProcedimientoDetalles;
  final ProcedimientoPlantilla procedimientoPlantilla;

  DetalleProcedimiento({
    required this.idHcProcedimiento,
    required this.idHistorialClinico,
    required this.idUneg,
    required this.idSucursal,
    required this.descripcion,
    required this.idPlantilla,
    required this.urlTrazos,
    required this.fechaRegistro,
    required this.userRegister,
    this.fechaModifica,
    this.userModifica,
    required this.estadoReg,
    required this.nombre,
    required this.hcProcedimientoDetalles,
    required this.procedimientoPlantilla,
  });

  factory DetalleProcedimiento.fromJson(Map<String, dynamic> json) {
    var list = json['hc_procedimiento_detalles'] as List;
    List<ProcedimientoDetalle> detallesList = list.map((i) => ProcedimientoDetalle.fromJson(i)).toList();

    return DetalleProcedimiento(
      idHcProcedimiento: json['id_hc_procedimiento'],
      idHistorialClinico: json['id_historial_clinico'],
      idUneg: json['id_uneg'],
      idSucursal: json['id_sucursal'],
      descripcion: json['descripcion'],
      idPlantilla: json['id_plantilla'],
      urlTrazos: json['url_trazos'],
      fechaRegistro: json['fecha_registro'],
      userRegister: json['user_register'],
      fechaModifica: json['fecha_modifica'],
      userModifica: json['user_modifica'],
      estadoReg: json['estado_reg'],
      nombre: json['nombre'],
      hcProcedimientoDetalles: detallesList,
      procedimientoPlantilla: ProcedimientoPlantilla.fromJson(json['procedimientoPlantilla']),
    );
  }
}

class ProcedimientoDetalle {
  final int idHcProcedimientoDetalle;
  final int idHcProcedimiento;
  final int idUneg;
  final int dosis;
  final String zona;
  final String tipoMarca;
  final bool estadoReg;
  final String fechaRegistro;
  final String userRegister;
  final String? fechaModifica;
  final String? userModifica;

  ProcedimientoDetalle({
    required this.idHcProcedimientoDetalle,
    required this.idHcProcedimiento,
    required this.idUneg,
    required this.dosis,
    required this.zona,
    required this.tipoMarca,
    required this.estadoReg,
    required this.fechaRegistro,
    required this.userRegister,
    this.fechaModifica,
    this.userModifica,
  });

  factory ProcedimientoDetalle.fromJson(Map<String, dynamic> json) {
    return ProcedimientoDetalle(
      idHcProcedimientoDetalle: json['id_hc_procedimiento_detalle'],
      idHcProcedimiento: json['id_hc_procedimiento'],
      idUneg: json['id_uneg'],
      dosis: json['dosis'],
      zona: json['zona'],
      tipoMarca: json['tipoMarca'],
      estadoReg: json['estado_reg'],
      fechaRegistro: json['fecha_registro'],
      userRegister: json['user_register'],
      fechaModifica: json['fecha_modifica'],
      userModifica: json['user_modifica'],
    );
  }
}

class ProcedimientoPlantilla {
  final int idPlantilla;
  final int idUneg;
  final String descripcion;
  final String url;
  final int idEspecialidad;
  final int idTipoProcedimiento;
  final String fechaRegistro;
  final String userRegister;
  final String? fechaModifica;
  final String? userModifica;
  final bool estadoReg;
  final int idBase;
  final TipoProcedimiento tipoProcedimiento;

  ProcedimientoPlantilla({
    required this.idPlantilla,
    required this.idUneg,
    required this.descripcion,
    required this.url,
    required this.idEspecialidad,
    required this.idTipoProcedimiento,
    required this.fechaRegistro,
    required this.userRegister,
    this.fechaModifica,
    this.userModifica,
    required this.estadoReg,
    required this.idBase,
    required this.tipoProcedimiento,
  });

  factory ProcedimientoPlantilla.fromJson(Map<String, dynamic> json) {
    return ProcedimientoPlantilla(
      idPlantilla: json['id_plantilla'],
      idUneg: json['id_uneg'],
      descripcion: json['descripcion'],
      url: json['url'],
      idEspecialidad: json['id_especialidad'],
      idTipoProcedimiento: json['id_tipo_procedimiento'],
      fechaRegistro: json['fecha_registro'],
      userRegister: json['user_register'],
      fechaModifica: json['fecha_modifica'],
      userModifica: json['user_modifica'],
      estadoReg: json['estado_reg'],
      idBase: json['id_base'],
      tipoProcedimiento: TipoProcedimiento.fromJson(json['tipoProcedimiento']),
    );
  }
}

class TipoProcedimiento {
  final int idTipoProcedimiento;
  final int idEspecialidad;
  final String descripcion;
  final String fechaRegistro;
  final String userRegister;
  final String? fechaModifica;
  final String? userModifica;
  final bool estadoReg;
  final int idUneg;
  final int idBase;

  TipoProcedimiento({
    required this.idTipoProcedimiento,
    required this.idEspecialidad,
    required this.descripcion,
    required this.fechaRegistro,
    required this.userRegister,
    this.fechaModifica,
    this.userModifica,
    required this.estadoReg,
    required this.idUneg,
    required this.idBase,
  });

  factory TipoProcedimiento.fromJson(Map<String, dynamic> json) {
    return TipoProcedimiento(
      idTipoProcedimiento: json['id_tipoProcedimiento'],
      idEspecialidad: json['id_especialidad'],
      descripcion: json['descripcion'],
      fechaRegistro: json['fecha_registro'],
      userRegister: json['user_register'],
      fechaModifica: json['fecha_modifica'],
      userModifica: json['user_modifica'],
      estadoReg: json['estado_reg'],
      idUneg: json['id_uneg'],
      idBase: json['id_base'],
    );
  }
}

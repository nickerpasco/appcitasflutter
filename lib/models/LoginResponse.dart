
class LoginResponse {
  final Data? data;
  final String? token;
  final dynamic v1;
  final bool? v2;
  final dynamic user;
  final dynamic roles;
  final dynamic menus;

  LoginResponse({this.data, this.token, this.v1, this.v2, this.user, this.roles, this.menus});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    data: json['data'] != null ? Data.fromJson(json['data']) : null,
    token: json['token'],
    v1: json['v1'],
    v2: json['v2'],
    user: json['user'],
    roles: json['roles'],
    menus: json['menus'],
  );

  Map<String, dynamic> toJson() => {
    'data': data?.toJson(),
    'token': token,
    'v1': v1,
    'v2': v2,
    'user': user,
    'roles': roles,
    'menus': menus,
  };
}

class Data {
  final String? urlPublic;
  final String? email;
  final String? name;
  final String? surname;
  final String? id;
  final String? image;
  final int? documentNumber;
  final List<dynamic>? roles;
  final List<dynamic>? empresas;
  final List<dynamic>? menus;
  final List<dynamic>? entities;
  final List<PacienteEmpresa>? pacienteEmpresa;
  final Persona? persona;
  final Entity? entity;
  final int? tipoUsuario;

  Data({
    this.urlPublic,
    this.email,
    this.name,
    this.surname,
    this.id,
    this.image,
    this.documentNumber,
    this.roles,
    this.empresas,
    this.menus,
    this.entities,
    this.pacienteEmpresa,
    this.persona,
    this.entity,
    this.tipoUsuario,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    urlPublic: json['urlPublic'],
    email: json['email'],
    name: json['name'],
    surname: json['surname'],
    id: json['id'],
    image: json['image'],
    documentNumber: json['documentNumber'],
    roles: json['roles'],
    empresas: json['empresas'],
    menus: json['menus'],
    entities: json['entities'],
    pacienteEmpresa: (json['pacienteEmpresa'] as List?)?.map((e) => PacienteEmpresa.fromJson(e)).toList(),
    persona: json['persona'] != null ? Persona.fromJson(json['persona']) : null,
    entity: json['entity'] != null ? Entity.fromJson(json['entity']) : null,
    tipoUsuario: json['tipoUsuario'],
  );

  Map<String, dynamic> toJson() => {
    'urlPublic': urlPublic,
    'email': email,
    'name': name,
    'surname': surname,
    'id': id,
    'image': image,
    'documentNumber': documentNumber,
    'roles': roles,
    'empresas': empresas,
    'menus': menus,
    'entities': entities,
    'pacienteEmpresa': pacienteEmpresa?.map((e) => e.toJson()).toList(),
    'persona': persona?.toJson(),
    'entity': entity?.toJson(),
    'tipoUsuario': tipoUsuario,
  };
}

class PacienteEmpresa {
  final int? idPacienteEmpresa;
  final String? idUser;
  final int? idUneg;
  final int? idCliente;
  final String? userRegister;
  final String? fechaRegistro;
  final bool? estadoReg;

  PacienteEmpresa({
    this.idPacienteEmpresa,
    this.idUser,
    this.idUneg,
    this.idCliente,
    this.userRegister,
    this.fechaRegistro,
    this.estadoReg,
  });

  factory PacienteEmpresa.fromJson(Map<String, dynamic> json) => PacienteEmpresa(
    idPacienteEmpresa: json['id_pacienteEmpresa'],
    idUser: json['id_user'],
    idUneg: json['id_uneg'],
    idCliente: json['id_cliente'],
    userRegister: json['user_register'],
    fechaRegistro: json['fecha_registro'],
    estadoReg: json['estado_reg'],
  );

  Map<String, dynamic> toJson() => {
    'id_pacienteEmpresa': idPacienteEmpresa,
    'id_user': idUser,
    'id_uneg': idUneg,
    'id_cliente': idCliente,
    'user_register': userRegister,
    'fecha_registro': fechaRegistro,
    'estado_reg': estadoReg,
  };
}

class Persona {
  final int? idPersona;
  final String? nombre;
  final String? apellidoPaterno;
  final String? apellidoMaterno;
  final String? dni;
  final String? telefonoPais;
  final String? telefono;
  final bool? flagTelefono;
  final String? email;
  final String? direccion;
  final String? fechaNacimiento;
  final int? idGenero;
  final bool? estadoReg;
  final String? fechaRegistro;
  final String? userRegister;
  final String? fechaModifica;
  final String? userModifica;
  final int? idUneg;
  final String? nacionalidad;
  final String? telefonoFijo;
  final int? idDepartamento;
  final int? idProvincia;
  final int? idDistrito;

  Persona({
    this.idPersona,
    this.nombre,
    this.apellidoPaterno,
    this.apellidoMaterno,
    this.dni,
    this.telefonoPais,
    this.telefono,
    this.flagTelefono,
    this.email,
    this.direccion,
    this.fechaNacimiento,
    this.idGenero,
    this.estadoReg,
    this.fechaRegistro,
    this.userRegister,
    this.fechaModifica,
    this.userModifica,
    this.idUneg,
    this.nacionalidad,
    this.telefonoFijo,
    this.idDepartamento,
    this.idProvincia,
    this.idDistrito,
  });

  factory Persona.fromJson(Map<String, dynamic> json) => Persona(
    idPersona: json['id_persona'],
    nombre: json['nombre'],
    apellidoPaterno: json['apellido_paterno'],
    apellidoMaterno: json['apellido_materno'],
    dni: json['dni'],
    telefonoPais: json['telefono_pais'],
    telefono: json['telefono'],
    flagTelefono: json['falg_telefono'],
    email: json['email'],
    direccion: json['direccion'],
    fechaNacimiento: json['fecha_nacimiento'],
    idGenero: json['id_genero'],
    estadoReg: json['estado_reg'],
    fechaRegistro: json['fechaRegistro'],
    userRegister: json['userRegister'],
    fechaModifica: json['fechaModifica'],
    userModifica: json['userModifica'],
    idUneg: json['idUneg'],
    nacionalidad: json['nacionalidad'],
    telefonoFijo: json['telefono_fijo'],
    idDepartamento: json['id_departamento'],
    idProvincia: json['id_provincia'],
    idDistrito: json['id_distrito'],
  );

  Map<String, dynamic> toJson() => {
    'id_persona': idPersona,
    'nombre': nombre,
    'apellido_paterno': apellidoPaterno,
    'apellido_materno': apellidoMaterno,
    'dni': dni,
    'telefono_pais': telefonoPais,
    'telefono': telefono,
    'falg_telefono': flagTelefono,
    'email': email,
    'direccion': direccion,
    'fecha_nacimiento': fechaNacimiento,
    'id_genero': idGenero,
    'estado_reg': estadoReg,
    'fechaRegistro': fechaRegistro,
    'userRegister': userRegister,
    'fechaModifica': fechaModifica,
    'userModifica': userModifica,
    'idUneg': idUneg,
    'nacionalidad': nacionalidad,
    'telefono_fijo': telefonoFijo,
    'id_departamento': idDepartamento,
    'id_provincia': idProvincia,
    'id_distrito': idDistrito,
  };
}

class Entity {
  final String? id;

  Entity({this.id});

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
    id: json['id'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
  };
}

class ClienteFotoModel {
  final int idClienteFoto;
  final int idCliente;
  final String url;
  final String fechaRegistro;

  ClienteFotoModel({
    required this.idClienteFoto,
    required this.idCliente,
    required this.url,
    required this.fechaRegistro,
  });

  factory ClienteFotoModel.fromJson(Map<String, dynamic> json) {
    return ClienteFotoModel(
      idClienteFoto: json['id_cliente_foto'],
      idCliente: json['id_cliente'],
      url: json['url'],
      fechaRegistro: json['fecha_registro'] ?? '',
    );
  }
}

import 'package:flutter/material.dart';
import '../models/cliente_foto_model.dart';
import '../services/cliente_foto_service.dart';

class ClienteFotoProvider extends ChangeNotifier {
  List<ClienteFotoModel> _fotos = [];
  bool _isLoading = false;

  List<ClienteFotoModel> get fotos => _fotos;
  bool get isLoading => _isLoading;

  Future<void> cargarFotos() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await ClienteFotoService().getFotosCliente();
      _fotos = data;
    } catch (e) {
      _fotos = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}

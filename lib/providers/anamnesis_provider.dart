import 'package:flutter/material.dart';
import '../models/AnamnesisModel.dart';
import '../services/AnamnesisService.dart';

class AnamnesisProvider with ChangeNotifier {
  List<AnamnesisModel> _lista = [];
  bool _isLoading = false;

  List<AnamnesisModel> get lista => _lista;
  bool get isLoading => _isLoading;

  Future<void> cargarAnamnesis() async {
    _isLoading = true;
    notifyListeners();

    try {
      _lista = await AnamnesisService().fetchAnamnesis();
    } catch (e) {
      print('Error al obtener anamnesis: $e');
      _lista = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}

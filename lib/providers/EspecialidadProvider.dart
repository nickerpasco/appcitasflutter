import 'package:flutter/material.dart';
import '../models/especialidad.dart';
import '../services/EspecialidadService.dart';

class EspecialidadProvider with ChangeNotifier {
  List<EspecialidadModel> _especialidades = [];
  bool _isLoading = false;

  final TextEditingController searchController = TextEditingController();

  List<EspecialidadModel> get especialidades => _especialidades;
  bool get isLoading => _isLoading;

  Future<void> fetchEspecialidades({String? especialidad}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await EspecialidadService().fetchEspecialidades(especialidad: especialidad);
      _especialidades = result;
    } catch (e) {
      _especialidades = [];
      debugPrint('Error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void buscarEspecialidades() {
    fetchEspecialidades(especialidad: searchController.text.trim());
  }
}

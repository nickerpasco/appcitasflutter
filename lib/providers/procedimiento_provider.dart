import 'package:flutter/material.dart';
import '../models/procedimiento_model.dart';
import '../services/procedimiento_service.dart';

class ProcedimientoProvider with ChangeNotifier {
  final List<DetalleProcedimiento> _procedimientos = [];
  bool _isLoading = false;

  List<DetalleProcedimiento> get procedimientos => _procedimientos;
  bool get isLoading => _isLoading;

  Future<void> cargarProcedimientos() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await ProcedimientoService().fetchProcedimientos();
      _procedimientos.clear();
      _procedimientos.addAll(data);
    } catch (e) {
      print('Error al obtener procedimientos: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}

import 'dart:math';
import 'package:flutter/material.dart';

/// Retorna un CircleAvatar que:
/// - Si [imageUrl] es distinto de null y no está vacío, carga la imagen desde la URL.
/// - Si [imageUrl] es null o vacío, genera un fondo de color aleatorio y muestra las iniciales
///   basadas en [firstName] y [lastName].
Widget foto_ui({
  required String? imageUrl,
  required String firstName,
  required String lastName,
  double radius = 40,
}) {
  // Helper para generar un color aleatorio
  Color _randomBackground() {
    final random = Random();
    return Colors.primaries[random.nextInt(Colors.primaries.length)].shade400;
  }

  // Helper para obtener las iniciales
  String _getInitials() {
    final firstInitial = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final lastInitial = lastName.isNotEmpty ? lastName[0].toUpperCase() : '';
    return '$firstInitial$lastInitial';
  }

  if (imageUrl != null && imageUrl.trim().isNotEmpty) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey.shade200,
      backgroundImage: NetworkImage(imageUrl),
    );
  } else {
    return CircleAvatar(
      radius: radius,
      backgroundColor: _randomBackground(),
      child: Text(
        _getInitials(),
        style: TextStyle(
          color: Colors.white,
          fontSize: radius * 0.6,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
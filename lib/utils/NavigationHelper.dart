import 'package:flutter/material.dart';

class NavigationHelper {
  // Navegar a una nueva pantalla y reemplazar la actual
  static Future<void> navegarYReemplazar(BuildContext context, Widget nuevaPantalla) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nuevaPantalla),
    );
  }

  // Navegar a una nueva pantalla sin reemplazar la actual (permitiendo volver atrás)
  static Future<void> navegar(BuildContext context, Widget nuevaPantalla) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nuevaPantalla),
    );
  }

  // Navegar a una nueva pantalla y eliminar todas las pantallas anteriores
  static Future<void> navegarYEliminarHasta(BuildContext context, Widget nuevaPantalla) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => nuevaPantalla),
      (route) => false, // Remueve todas las rutas anteriores
    );
  }

  // Volver a la pantalla anterior
  static void volverAtras(BuildContext context) {
    Navigator.pop(context);
  }
}

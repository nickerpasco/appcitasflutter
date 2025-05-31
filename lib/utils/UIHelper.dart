import 'package:flutter/material.dart';

class UIHelper {
  static void mostrarMensaje(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        duration: Duration(seconds: 3),
      ),
    );
  }



   static Future<void> mostrarMensajeDialog({
    required BuildContext context,
    required String mensaje,
    String titulo = 'Mensaje',
    IconData icono = Icons.info,
    Color colorIcono = Colors.blueAccent,
  }) async {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icono, size: 48, color: colorIcono),
              const SizedBox(height: 16),
              Text(
                titulo,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                mensaje,
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: colorIcono,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Text('Aceptar', style: TextStyle(fontSize: 16,    color: Colors.white, ) ,  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

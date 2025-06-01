import 'dart:convert';

import 'package:app_salud_citas/models/LoginResponse.dart';
import 'package:app_salud_citas/vistas/componentes/foto_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/cliente_foto_provider.dart';

class ArchivoScreen extends StatefulWidget {
  const ArchivoScreen({super.key});

  @override
  State<ArchivoScreen> createState() => _ArchivoScreenState();
}

class _ArchivoScreenState extends State<ArchivoScreen> {
  String _nombreUsuario = 'Sin Nombre';
  String _apellidoPuser = 'Sin Ap Pat.';
  String _apellidoMuser = 'Sin Ap Mat.';
  String _nombreCompleto = '';
  String _fechaNacFormated = '';
  String urlImg = '';

    String urlConFoto = '';
    String _primerNombre = '';
    String _primerapellido = '';

  Future<void> cargarNombreUsuario() async {
    final prefs = await SharedPreferences.getInstance();
      final jsonUrlImagen = prefs.getString('urlImagenUsuarioLogin');

    urlConFoto = jsonUrlImagen.toString();
    final json = prefs.getString('user_data');
    if (json != null) {
      final data = LoginResponse.fromJson(jsonDecode(json));
      setState(() {
        //url
        urlImg=data.data?.urlPublic ?? '';
        _nombreUsuario = data.data?.persona?.nombre ?? 'Usuario';
        _apellidoPuser = data.data?.persona?.apellidoPaterno ?? '';
        _apellidoMuser = data.data?.persona?.apellidoMaterno ?? '';
        _nombreCompleto = _nombreUsuario + " " + _apellidoPuser + " " +_apellidoMuser;



        _primerNombre = data.data?.persona?.nombre ?? '';
        _primerapellido = data.data?.persona?.apellidoPaterno ?? '';

        //FechaNacimiento
        final nacimiento = DateTime.parse(data.data?.persona?.fechaNacimiento ?? DateTime.now().toString() );
        final hoy = DateTime.now();

        int anos = hoy.year - nacimiento.year;
        int meses = hoy.month - nacimiento.month;

        if (meses < 0 || (meses == 0 && hoy.day < nacimiento.day)) {
          anos--;
          meses += 12;
        }

        _fechaNacFormated = '$anos años y $meses meses';


      });
    }
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ClienteFotoProvider>(context, listen: false).cargarFotos();
      cargarNombreUsuario();
    });
  }

  @override
  Widget build(BuildContext context) {
    final fotoProvider = Provider.of<ClienteFotoProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/slectionUserBackground.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.menu, color: Colors.black),
                      Image.asset('assets/drLink.png', height: 32),
                      const Icon(Icons.call, color: Colors.black),
                    ],
                  ),
                  const SizedBox(height: 20),
               foto_ui(
                    imageUrl: urlConFoto,
                    firstName: _primerNombre,
                    lastName: _primerapellido,
                    radius: 50,
                  ),
                  const SizedBox(height: 12),
                  Text('$_nombreCompleto',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('$_fechaNacFormated  |  WhatsApp',
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: const [
                          _TabButton(label: 'H. Médico'),
                          SizedBox(width: 8),
                          _TabButton(label: 'Procedimientos'),
                          SizedBox(width: 8),
                          _TabButton(label: 'Historial'),
                          SizedBox(width: 8),
                          _TabButton(label: 'Archivos', selected: true),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Archivos Digitales',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: fotoProvider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : fotoProvider.fotos.isEmpty
                        ? const Center(child: Text('No hay imágenes disponibles.'))
                        : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: fotoProvider.fotos.length,
                      itemBuilder: (context, index) {
                        final foto = fotoProvider.fotos[index];
                        return Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  urlImg+foto.url,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            // const Text('Imagen', style: TextStyle(fontSize: 13))
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;

  const _TabButton({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.white : const Color(0xFF5CFCCC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF5CFCCC),
          width: 1.5,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

  import 'dart:convert';
  import 'package:app_salud_citas/constants/api_constants.dart';
  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;
  import 'package:provider/provider.dart';
  import 'package:shared_preferences/shared_preferences.dart';
  import 'package:app_salud_citas/models/LoginResponse.dart';
  import 'package:app_salud_citas/vistas/componentes/foto_ui.dart';
  import '../../providers/procedimiento_provider.dart';

  class RecetasScreen extends StatefulWidget {
    const RecetasScreen({super.key});

    @override
    State<RecetasScreen> createState() => _RecetasScreenState();
  }

  class _RecetasScreenState extends State<RecetasScreen> {
    String _nombreUsuario = 'Sin Nombre';
    String _apellidoPuser = 'Sin Ap Pat.';
    String _apellidoMuser = 'Sin Ap Mat.';
    String _nombreCompleto = '';
    String _fechaNacFormated = '';
    String urlConFoto = '';
    String _primerNombre = '';
    String _primerapellido = '';
    String urlCompletaPublica = '';

    // Variables para manejar los procedimientos
    List<dynamic> procedimientos = [];

    // Cargar el nombre de usuario
    Future<void> cargarNombreUsuario() async {
      final prefs = await SharedPreferences.getInstance();
      final jsonUrlImagen = prefs.getString('urlImagenUsuarioLogin');
      urlConFoto = jsonUrlImagen.toString();
      final json = prefs.getString('user_data');
      if (json != null) {
        final data = LoginResponse.fromJson(jsonDecode(json));
        setState(() {
          _nombreUsuario = data.data?.persona?.nombre ?? 'Usuario';
          _apellidoPuser = data.data?.persona?.apellidoPaterno ?? '';
          _apellidoMuser = data.data?.persona?.apellidoMaterno ?? '';
          _nombreCompleto = _nombreUsuario + " " + _apellidoPuser + " " +_apellidoMuser;
          _primerNombre = data.data?.persona?.nombre ?? '';
          _primerapellido = data.data?.persona?.apellidoPaterno ?? '';
          urlCompletaPublica = data.data?.urlPublic?? '';
          // Calcular la edad
          final nacimiento = DateTime.parse(data.data?.persona?.fechaNacimiento ?? DateTime.now().toString());
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

    // Realizar la llamada HTTP y obtener los procedimientos
    Future<void> obtenerProcedimientos() async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';
      final HC_DATA_ID = prefs.getInt('HC_DATA_ID') ?? '';

      final url = Uri.parse('${ApiConstants.baseUrl}/api/Hc_procedimiento/list-app?id_historial_clinico=$HC_DATA_ID');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          procedimientos = data['data'];
        });
      } else {
        throw Exception('Failed to load procedures');
      }
    }

    @override
    void initState() {
      super.initState();
      cargarNombreUsuario();
      obtenerProcedimientos(); // Cargar los procedimientos al inicio
    }

    // Función para concatenar la URL base con 'url_trazos'
    String urlCompleta(String urlTrazos) {
      String baseUrl = urlCompletaPublica;
      return baseUrl + urlTrazos;
    }

    // Formatear la fecha
    String formatDate(String date) {
      final dateTime = DateTime.parse(date);
      return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(
          children: [
            SizedBox.expand(
              child: Image.asset('assets/slectionUserBackground.png', fit: BoxFit.cover),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.menu),
                        Image.asset('assets/drLink.png', height: 32),
                        const Icon(Icons.call),
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
                    Text('$_fechaNacFormated  |  WhatsApp 2',
                        style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 16),
                    const _TabSelector(),

                    // Selector de periodo
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     IconButton(
                    //       icon: const Icon(Icons.arrow_left),
                    //       onPressed: () {},
                    //     ),
                    //     Container(
                    //       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    //       decoration: BoxDecoration(
                    //         color: const Color(0xFF2E687A),
                    //         borderRadius: BorderRadius.circular(8),
                    //       ),
                    //       child: const Text(
                    //         'Actual',
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ),
                    //     IconButton(
                    //       icon: const Icon(Icons.arrow_right),
                    //       onPressed: () {},
                    //     ),
                    //   ],
                    // ),

                    const SizedBox(height: 10),

                    // Listado de procedimientos
                    Expanded(
                      child: procedimientos.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: procedimientos.length,
                              itemBuilder: (context, index) {
                                final p = procedimientos[index];
                                return Container(
                                  margin: const EdgeInsets.symmetric(vertical: 8),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: const Color(0xFF5CFCCC)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Imagen cargada desde la URL
                                      p['url_trazos'] != null && p['url_trazos'] != ''
                                        ? Image.network(
                                            urlCompleta(p['url_trazos']),  // Aquí concatenamos la URL base con la URL de la imagen
                                            width: 50,         // Ajusta el tamaño de la imagen según lo que necesites
                                            height: 50,        // Ajusta el tamaño de la imagen según lo que necesites
                                            fit: BoxFit.cover, // Asegura que la imagen se ajuste bien en el contenedor
                                          )
                                        : const Icon(Icons.image, size: 50), // Imagen de placeholder en caso de no existir la URL

                                      const SizedBox(width: 8), // Espacio entre la imagen y los textos

                                      // Column con los textos
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Historial: ${p['id_historial_clinico']}',
                                                style: const TextStyle(fontWeight: FontWeight.bold)),
                                            Text('Nombre: ${p['nombre']}'),
                                            Text('Descripción: ${p['descripcion']}'),
                                            Text('Fecha: ${formatDate(p['fecha_registro'])}'), // Asumiendo que estás usando la función formatDate que mencioné antes
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),

                                      // Icono de flecha a la derecha
                                    GestureDetector(
  onTap: () {
    final detalles = p['hc_procedimiento_detalles'] ?? [];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(p['nombre']?.trim() ?? 'Detalles del procedimiento'),
        content: detalles.isEmpty
            ? const Text('No hay detalles disponibles.')
            : SizedBox(
                width: double.maxFinite,
                height: 300,
                child: ListView.builder(
                  itemCount: detalles.length,
                  itemBuilder: (context, i) {
                    final d = detalles[i];
                    final fecha = d['fecha_registro'] != null
                        ? DateTime.tryParse(d['fecha_registro'])?.toLocal().toString().substring(0, 16) ?? '---'
                        : '---';

                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Zona: ${d['zona'] ?? '---'}',
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text('Dosis: ${d['dosis'] ?? '---'}'),
                            const SizedBox(height: 4),
                            Text('Tipo de Marca: ${d['tipoMarca'] ?? '---'}'),
                            const SizedBox(height: 4),
                            Text('Fecha de Registro: $fecha'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
        actions: [
          TextButton(
            child: const Text('Cerrar'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  },
  child: const CircleAvatar(
    backgroundColor: Color(0xFF2E687A),
    child: Icon(Icons.arrow_forward, color: Colors.white),
  ),
),

                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  class _TabSelector extends StatelessWidget {
    const _TabSelector();

    @override
    Widget build(BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: const [
              _TabButton(label: 'Anamnésis'),
              const SizedBox(width: 8),
              _TabButton(label: 'Procedimientos', selected: true),
              const SizedBox(width: 8),
              _TabButton(label: 'Recetas'),
              const SizedBox(width: 8),
              _TabButton(label: 'Archivos'),
            ],
          ),
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
          border: Border.all(color: const Color(0xFF5CFCCC)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selected ? Colors.black : Colors.white,
          ),
        ),
      );
    }
  }

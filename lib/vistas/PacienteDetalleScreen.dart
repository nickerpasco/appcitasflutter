import 'package:flutter/material.dart';

class PacienteDetalleScreen extends StatelessWidget {
  const PacienteDetalleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/login.png', // mismo fondo que MenuClinicasPage
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Logo, íconos derecha
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Reemplazar si no existe el logo
                      // Image.asset('assets/logo.png', height: 32),
                      Text('Dr. Link', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Row(
                        children: const [
                          Icon(Icons.call, color: Colors.black54),
                          SizedBox(width: 12),
                          Icon(Icons.notifications_none, color: Colors.black54),
                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Avatar y datos
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/doctor.png'),
                  ),
                  const SizedBox(height: 12),
                  const Text('Roxana Jara Molinma',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text('0 Años Y 4 Meses  |  WhatsApp',
                      style: TextStyle(color: Colors.grey)),

                  const SizedBox(height: 16),

                  // Tabs
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _TabButton(label: 'H. Médico', selected: true),
                        _TabButton(label: 'Recetas'),
                        _TabButton(label: 'Historial'),
                        _TabButton(label: 'Archivos'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Contenido scrollable debajo de la línea roja
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Tarjeta de información médica
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.green, width: 1.5),
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Paciente Roxana Jaro'),
                                Text('21 marzo 2025 a la 03:18 pm'),
                                SizedBox(height: 12),
                                Text('Evolución y actualización del cuadro clínico', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('ddsaaa'),
                                SizedBox(height: 8),
                                Text('Resultado de estudios', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('ddsaaa'),
                                SizedBox(height: 8),
                                Text('Diagnóstico', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('leucemia'),
                                SizedBox(height: 8),
                                Text('Pronóstico', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('3 meses de vida'),
                                SizedBox(height: 8),
                                Text('Plan de tratamiento', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('quimioterapia'),
                                SizedBox(height: 8),
                                Text('Nota adicional', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('quimioterapia'),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Resultados laboratorio
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFCBF5E3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const ListTile(
                              title: Text('Resultados de laboratorio',
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Dr. Jacinto Peralta Muñoz'),
                                  Text('0318-1608-2105'),
                                ],
                              ),
                              trailing: Text('3:02 PM'),
                            ),
                          ),

                          const SizedBox(height: 80),
                        ],
                      ),
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

class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;

  const _TabButton({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF6EE4A3) : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: selected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

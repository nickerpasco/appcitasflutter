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
              'assets/slectionUserBackground.png',
              fit: BoxFit.cover,
            ),
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
                      const Icon(Icons.menu, color: Colors.black),
                      Image.asset(
                        'assets/drLink.png',
                        height: 32,
                      ),
                      const Icon(Icons.call, color: Colors.black),
                    ],
                  ),

                  const SizedBox(height: 20),

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
                        children: [
                          _TabButton(label: 'H. Médico', selected: true),
                          const SizedBox(width: 8),
                          _TabButton(label: 'Recetas'),
                          const SizedBox(width: 8),
                          _TabButton(label: 'Historial'),
                          const SizedBox(width: 8),
                          _TabButton(label: 'Archivos'),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: const Color(0xFF5CFCCC), width: 1.5),
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
                              Positioned(
                                bottom: -30,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF82EAC1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Resultados de laboratorio',
                                          style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text('Dr Jacinto Peralta Muñoz'),
                                      Text('0318–1608–2105'),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text('3:02 PM',
                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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

import 'package:flutter/material.dart';

class HistorialScreen extends StatelessWidget {
  const HistorialScreen({super.key});

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
                  // Header
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

                  const SizedBox(height: 20),

                  Expanded(
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFF5CFCCC)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('HISTORIALES Nº 1152539874', style: TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(height: 4),
                                  Text('Médico: MIKEY THOMPSSON HUGARTE'),
                                  Text('C. Asistencial: H.N. EDGARDO REBAGLIATI'),
                                  Text('Fecha: 26/4/2025      Hora: 03:35 pm'),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            const CircleAvatar(
                              backgroundColor: const Color(0xFF2E687A),
                              child: Icon(Icons.arrow_forward, color: Colors.white),
                            )
                          ],
                        ),
                      ),
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

import 'package:flutter/material.dart';

class MenuClinicasPage extends StatelessWidget {
  const MenuClinicasPage({super.key});

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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

                  // Avatar y saludo
                  Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/doctor.png'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Hola , Cristopher',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text('¿Cómo puedo ayudarte hoy?',
                      style: TextStyle(color: Colors.black)),
                  const SizedBox(height: 20),

                  // Buscador
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF5CFCCC),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search),
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Accesos rápidos
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      _IconButtonWithLabel(label: 'Agendar', assetImage: 'assets/perfilIco.png'),
                      _IconButtonWithLabel(label: 'Recetas', assetImage: 'assets/7.png'),
                      _IconButtonWithLabel(label: 'Procedimientos', assetImage: 'assets/8.png'),
                      _IconButtonWithLabel(label: 'Fotos', assetImage: 'assets/9.png'),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Notificación de cita
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Color(0xFF5CFCCC), width: 1.5),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notificación de cita',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF003333),
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Usted tiene una cita  en la sucursal de Miraflores\na las 03:18 pm del 25/04/2025',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Título lista de doctores
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Dr. Shen',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),

                  const SizedBox(height: 10),

                  // Lista scrollable de doctores
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(top: 8),
                      children: [
                        _DoctorCard(
                          name: 'Dr. Shen',
                          specialty: 'Cardiólogo y Cirujano',
                          location: 'Miraflores, cdra25',
                        ),
                        _DoctorCard(
                          name: 'Dr. Shon',
                          specialty: 'Dentista general',
                          location: 'Miraflores, cdra25',
                        ),
                        _DoctorCard(
                          name: 'Dr. Shon',
                          specialty: 'Dentista general',
                          location: 'Miraflores, cdra25',
                        ),
                        _DoctorCard(
                          name: 'Dr. Shon',
                          specialty: 'Dentista general',
                          location: 'Miraflores, cdra25',
                        ),
                        _DoctorCard(
                          name: 'Dr. Shon',
                          specialty: 'Dentista general',
                          location: 'Miraflores, cdra25',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _IconButtonWithLabel extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String? assetImage;

  const _IconButtonWithLabel({this.icon, required this.label, this.assetImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        assetImage != null
            ? Image.asset(assetImage!, height: 32, width: 32)
            : Icon(icon, size: 32, color: Colors.green),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12))
      ],
    );
  }
}

class _DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String location;

  const _DoctorCard({
    required this.name,
    required this.specialty,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage('assets/doctor.png'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF4B2C20),
                  ),
                ),
                Text(
                  specialty,
                  style: const TextStyle(fontSize: 14),
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.green, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Row(
            children: const [
              Icon(Icons.star, color: Colors.amber, size: 18),
              SizedBox(width: 4),
              Text(
                '4.9',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}

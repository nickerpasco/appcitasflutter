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
              'assets/login.png',
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
                    children: const [
                      Icon(Icons.menu, color: Colors.black),
                      Text('Clínicas',
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      Icon(Icons.call, color: Colors.black),
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
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text('¿Cómo puedo ayudarte hoy?',
                      style: TextStyle(color: Colors.green)),
                  const SizedBox(height: 20),

                  // Buscador
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
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
                      _IconButtonWithLabel(Icons.person, 'Perfil'),
                      _IconButtonWithLabel(Icons.calendar_month, 'Reservas'),
                      _IconButtonWithLabel(Icons.history, 'Historial médico'),
                      _IconButtonWithLabel(Icons.more_horiz, 'Más'),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Notificación de cita
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF9F3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(
                          child: Text(
                            'Usted tiene una cita en la sucursal de Miraflores a las 03:18 pm del 25/04/2025',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, size: 16)
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
                      padding: const EdgeInsets.only(top: 8),
                      children: const [
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
  final IconData icon;
  final String label;

  const _IconButtonWithLabel(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: const Color(0xFFEAF9F3),
          child: Icon(icon, color: Colors.green),
        ),
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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/doctor.png'),
        ),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(specialty),
            Text(location),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.star, color: Colors.amber, size: 16),
            Text('4.9'),
          ],
        ),
      ),
    );
  }
}

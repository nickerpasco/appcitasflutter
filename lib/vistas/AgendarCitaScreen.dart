import 'dart:convert';

import 'package:app_salud_citas/controllers/CitaController.dart';
import 'package:app_salud_citas/models/LoginResponse.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/horario_provider.dart';

class AgendarCitaScreen extends StatefulWidget {
  final String nombreDoctor;
  final String nombrePaciente;
  final int idEspecialidad;
  final int idEmpleado;
  final String nombreEspecialidad;

  const AgendarCitaScreen({
    super.key,
    required this.nombreDoctor,
    required this.nombrePaciente,
    required this.idEspecialidad,
    required this.idEmpleado,
    required this.nombreEspecialidad,
  });

  @override
  State<AgendarCitaScreen> createState() => _AgendarCitaScreenState();
}
 
class _AgendarCitaScreenState extends State<AgendarCitaScreen> {
  DateTime selectedDate = DateTime.now();
  final _scrollController = ScrollController();

  final nombreController = TextEditingController();
  final telefonoController = TextEditingController();
  final comentarioController = TextEditingController();

  String _nombreUsuario = 'Sin Nombre';
  String _apellidoPuser = 'Sin Ap Pat.';
  String _apellidoMuser = 'Sin Ap Mat.';
  String _nombreCompleto = '';
  String _fechaNacFormated = '';

  Future<void> cargarNombreUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('user_data');
    if (json != null) {
      final data = LoginResponse.fromJson(jsonDecode(json));
      setState(() {
        _nombreUsuario = data.data?.persona?.nombre ?? 'Usuario';
        _apellidoPuser = data.data?.persona?.apellidoPaterno ?? '';
        _apellidoMuser = data.data?.persona?.apellidoMaterno ?? '';
        _nombreCompleto = _nombreUsuario + " " + _apellidoPuser + " " +_apellidoMuser;
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

  final List<String> horasDisponibles = List.generate(30, (index) {
    final hour = 4 + (index ~/ 2);
    final minute = (index % 2) * 30;
    final time = TimeOfDay(hour: hour, minute: minute);
    final hourStr = time.hourOfPeriod.toString().padLeft(2, '0');
    final minuteStr = time.minute.toString().padLeft(2, '0');
    final periodStr = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hourStr:$minuteStr $periodStr';
  });

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<HorarioProvider>(context, listen: false);
      cargarNombreUsuario();
      provider.setDoctor(widget.nombreDoctor);
      provider.setNombre(widget.nombrePaciente);
      provider.setEspecialidad(widget.nombreEspecialidad);
      provider.cargarHorasNoDisponibles(
        fecha: selectedDate,
        idUneg: 1,
        idEmpleado: widget.idEmpleado,
      );
    });
  }

  void _onDateChange(DateTime date) {
    final today = DateTime.now();
    final truncatedToday = DateTime(today.year, today.month, today.day);

    if (date.isBefore(truncatedToday)) return;

    setState(() {
      selectedDate = date;
    });

    Provider.of<HorarioProvider>(context, listen: false).cargarHorasNoDisponibles(
      fecha: date,
      idUneg: 1,
      idEmpleado: widget.idEmpleado,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HorarioProvider>(context);
    final today = DateTime.now();
    final truncatedToday = DateTime(today.year, today.month, today.day);
    final horasNoDisponibles = provider.horasNoDisponibles;

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
                      Image.asset('assets/drLink.png', height: 32),
                      const Icon(Icons.call, color: Colors.black),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('DOCTOR *'),
                        const SizedBox(height: 4),
                        TextFormField(
                          initialValue: Provider.of<HorarioProvider>(context).doctor ?? widget.nombreDoctor,
                          readOnly: true,
                          decoration: _inputStyle("Seleccione doctor"),
                        ),
                        if (provider.errorDoctor != null)
                          Text(provider.errorDoctor!, style: const TextStyle(color: Colors.red)),

                        const SizedBox(height: 16),
                        const Text('ESPECIALIDAD *'),
                        const SizedBox(height: 4),
                        TextFormField(
                          initialValue: Provider.of<HorarioProvider>(context).especialidad ?? widget.nombreEspecialidad,
                          readOnly: true,
                          decoration: _inputStyle("Seleccione especialidad"),
                        ),
                        if (provider.errorEspecialidad != null)
                          Text(provider.errorEspecialidad!, style: const TextStyle(color: Colors.red)),

                        const SizedBox(height: 16),
                        const Text('DÍA *'),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6DFBBA), Color(0xFFDBF7A5)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DatePicker(
                            truncatedToday,
                            width: 60,
                            height: 90,
                            daysCount: 90,
                            initialSelectedDate: selectedDate,
                            selectionColor: const Color(0xFF2E687A),
                            selectedTextColor: Colors.white,
                            locale: "es_ES",
                            onDateChange: _onDateChange,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          const Text("Tiempo disponible", style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 200,
                            child: Scrollbar(
                              controller: _scrollController,
                              thumbVisibility: true,
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: horasDisponibles.map((hora) {
                                    final isDisabled = horasNoDisponibles.any((h) => h.startsWith(hora.split(' ')[0]));
                                    final selected = provider.horaSeleccionada == hora;
                                    return ChoiceChip(
                                      label: Text(hora),
                                      selected: selected,
                                      selectedColor: const Color(0xFF2E687A),
                                      onSelected: isDisabled ? null : (_) {
                                        provider.setHora(hora);
                                      },
                                      disabledColor: Colors.grey.shade300,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          if (provider.errorHora != null)
                            Text(provider.errorHora!, style: const TextStyle(color: Colors.red)),

                          const SizedBox(height: 24),
                          const Text("Información del contacto", style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          TextFormField(
                            //controller: nombreController,
                            initialValue: Provider.of<HorarioProvider>(context).nombre ?? widget.nombrePaciente,
                            decoration: _inputStyle("Nombre"),
                            onChanged: provider.setNombre,
                          ),
                          if (provider.errorNombre != null)
                            Text(provider.errorNombre!, style: const TextStyle(color: Colors.red)),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: telefonoController,
                            decoration: _inputStyle("Teléfono", prefix: const Icon(Icons.flag)),
                            keyboardType: TextInputType.phone,
                            onChanged: provider.setTelefono,
                          ),
                          if (provider.errorTelefono != null)
                            Text(provider.errorTelefono!, style: const TextStyle(color: Colors.red)),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: comentarioController,
                            maxLines: 3,
                            decoration: _inputStyle("Comentarios"),
                          ),
                          const SizedBox(height: 24),

                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2E687A),
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                final valido = provider.validarFormulario();
                                if (valido) {
                                  // Lógica de agendamiento aquí
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Cita agendada correctamente")),
                                  );
                                }
                              },
                              child: const Text("CONFIRMAR CITA", style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          const SizedBox(height: 24),
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

  InputDecoration _inputStyle(String hint, {Widget? prefix}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      prefixIcon: prefix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }



    void agendarCita() async {






  final CitaController controller = CitaController(); // tu URL real


    final payload = armarPayload();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Agendando cita...")),
    );

    final result = await controller.agendarCita(payload);

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Cita agendada correctamente")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error: ${result['error']}")),
      );
    }
  }



  
  Map<String, dynamic> armarPayload() {
    return {
      "CitaDto": {
        "Cita": {
          "id_cliente": 12,
          "id_empleado": 5,
          "id_motivo": null,
          "id_especialidad": 3,
          "horaDuracion": 1,
          "minutosDuracion": 30,
          "fechaInicio": "2025-04-25T15:00:00",
          "horaInicio": "15:00:00",
          "id_consultorio": null,
          "id_frecuencia": null,
          "nota": "Paciente con antecedentes",
          "estadoCitaMedica": 1,
          "app_nombre": "app_nombre",
          "app_codigo_pais": "+51",
          "app_telefono": "993430563",
          "end": "2025-04-25T15:00:00",
          "start": "2025-04-25T15:00:00",
          "app_comentario": "comentario",
          "nombre_completo": "nombre usuario logeado"
        },
        "citaServicio": [
          {"id_servicio": 10}
        ],
        "id_uneg": 1
      },
      "EventoCalendar": {
        "idUsuario": "2628df95-e732-4a44-8c7b-f67abfe34b21",
        "summary": "Reunion Skin Center - Sala 2",
        "location": "Av. Alfredo Benavides 1335, Miraflores 15047",
        "start": {
          "dateTime": "2025-04-25T15:00:00",
          "timeZone": "America/Lima"
        },
        "end": {
          "dateTime": "2025-04-25T16:30:00",
          "timeZone": "America/Lima"
        },
        "Attendees": [
          {"Email": "keny@gmail.com"}
        ]
      }
    };
  }
}

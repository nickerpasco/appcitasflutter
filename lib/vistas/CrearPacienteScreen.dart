import 'package:flutter/material.dart';
import 'package:app_salud_citas/controllers/paciente_controller.dart';

class CrearPacienteScreen extends StatefulWidget {
  @override
  _CrearPacienteScreenState createState() => _CrearPacienteScreenState();
}

class _CrearPacienteScreenState extends State<CrearPacienteScreen> {
  final PacienteController _controller = PacienteController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Fondo
            Positioned.fill(
              child: Image.asset(
                'assets/crearpacienteBackgorund.png',
                fit: BoxFit.cover,
              ),
            ),

            // Contenido
            Column(
              children: [
                // Encabezado
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/ic_back.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E687A),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            'Nuevo usuario',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),


                // Formulario con scroll
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.83,
                        ),
                        child: _buildFormulario(),
                      ),
                    ),
                  ),
                ),

                // Botón fijo
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _controller.submitForm(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2EF7B7),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Crear paciente'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormulario() {
    return Form(
      key: _controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Tipo de documento"),
                    const SizedBox(height: 4),
                    DropdownButtonFormField<String>(
                      value: _controller.selectedDocType,
                      onChanged: (value) {
                        setState(() => _controller.selectedDocType = value!);
                      },
                      isExpanded: true,
                      items: ["DNI", "CE", "Pasaporte"]
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      decoration: inputDecoration(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Documento"),
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: _controller.documentoController,
                        decoration: inputDecoration().copyWith(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        ),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Checkbox(value: false, onChanged: (_) {}),
              const Text("No tiene número de documento"),
            ],
          ),
          const SizedBox(height: 12),
          buildRequiredLabel('Nombre'),
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: _controller.nombreController,
              decoration: inputDecoration().copyWith(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              ),
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(height: 12),
          buildRequiredLabel('Apellidos'),
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: _controller.apellidoController,
              decoration: inputDecoration().copyWith(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              ),
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(height: 12),
          buildRequiredLabel('Teléfono'),
          Row(
            children: [
              DropdownButton<String>(
                value: _controller.selectedCountryCode,
                underline: Container(),
                onChanged: (value) {
                  final country = _controller.countryOptions.firstWhere((c) => c['code'] == value);
                  setState(() {
                    _controller.selectedCountryCode = value!;
                    _controller.selectedFlag = country['flag']!;
                  });
                },
                items: _controller.countryOptions
                    .map((country) => DropdownMenuItem<String>(
                  value: country['code'],
                  child: Text('${country['flag']} ${country['code']}'),
                ))
                    .toList(),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    controller: _controller.telefonoController,
                    keyboardType: TextInputType.phone,
                    decoration: inputDecoration().copyWith(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    ),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Email'),
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: _controller.emailController,
              decoration: inputDecoration(hint: 'ejemplo@gmail.com').copyWith(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              ),
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(height: 12),
          const Text('F. Nacimiento'),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _controller.selectedDia,
                  hint: const Text("Día"),
                  isExpanded: true,
                  items: List.generate(31, (i) => '${i + 1}')
                      .map((day) => DropdownMenuItem(value: day, child: Text(day)))
                      .toList(),
                  onChanged: (val) => setState(() => _controller.selectedDia = val),
                  decoration: inputDecoration(),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _controller.selectedMes,
                  hint: const Text("Mes"),
                  isExpanded: true,
                  items: List.generate(12, (i) => '${i + 1}')
                      .map((month) => DropdownMenuItem(value: month, child: Text(month)))
                      .toList(),
                  onChanged: (val) => setState(() => _controller.selectedMes = val),
                  decoration: inputDecoration(),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _controller.selectedAnio,
                  hint: const Text("Año"),
                  isExpanded: true,
                  items: List.generate(100, (i) => '${DateTime.now().year - i}')
                      .map((year) => DropdownMenuItem(value: year, child: Text(year)))
                      .toList(),
                  onChanged: (val) => setState(() => _controller.selectedAnio = val),
                  decoration: inputDecoration(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          buildRequiredLabel("Usuario"),
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: _controller.usuarioController,
              decoration: inputDecoration().copyWith(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              ),
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(height: 12),
          buildRequiredLabel("Clave"),
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: _controller.claveController,
              decoration: inputDecoration().copyWith(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              ),
              obscureText: true,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }


  InputDecoration inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF83FAD9), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF83FAD9), width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }


  Widget buildRequiredLabel(String label) {
    return RichText(
      text: TextSpan(
        text: '$label ',
        style: const TextStyle(color: Colors.black, fontSize: 16),
        children: const [
          TextSpan(
            text: '*',
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
